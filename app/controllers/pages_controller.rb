class PagesController < ApplicationController
  before_action :assign_page, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: :display

  def display
    assign_page_for_display
    @title = @page.title
    set_state_for_page
  end

  def index
    @top_level_pages = Page.where(parent: nil).asc(:order)
    @child_pages = Page.not.where(parent: nil).asc(:parent_id).asc(:order)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    flash[:notice] = "Page was successfully created." if @page.save
    redirect_to display_page_path(@page)
  end

  def update
    if @page.update(page_params)
      params[:delete_existing_attachments].each do |id|
        Attachment.find(id).destroy!
      end if params[:delete_existing_attachments]

      params[:new_attachments].each do |attachment|
        @page.attachments.create!(attachment: attachment) if attachment.present?
      end if params[:new_attachments]

      flash[:notice] = "Page was successfully updated."
    end

    redirect_to display_page_path(@page)
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  def reorder
    docs = params.require(:data)

    docs.each do |id, order|
      doc = Page.find(id)
      doc.order = order
      doc.save!
    end

    render json: { updated: docs.length }
  end

  private

  def display_page_path(page)
    if page.collection?
      display_page_path(page.children.first || Page.homepage)
    else
      "/#{page.identifier}"
    end
  end

  def assign_page
    @page = Page.find(params[:id])
  end

  def assign_page_for_display
    if params[:id]
      @page = Page.find_by(identifier: params[:id])
    else
      @page = Page.homepage
    end
  end

  def page_params
    params.require(:page).permit(:title, :content, :type, :parent_id)
  end

  def set_state_for_page
    case @page.type
    when "homepage" then set_state_for_homepage
    when "news" then set_state_for_news
    when "photos" then set_state_for_photos
    when "sermons" then set_state_for_sermons
    end
  end

  def set_state_for_homepage
    @title = nil
  end

  def set_state_for_news
    if params[:date] and params[:date] =~ /(\d{4})(\d\d)(\d\d)/
      @date = Time.local $1.to_i, $2.to_i, $3.to_i
    else
      @date = Time.now.midnight
    end

    @news_week = NewsWeek.new(@date)
  end

  def set_state_for_photos
    galleries = Photo.all.distinct(:gallery).sort
    @photos = []
    galleries.each do |gallery|
      @photos << [gallery, Photo.where(gallery: gallery).limit(4)]
    end
  end

  def set_state_for_sermons
    @sermons = Sermon.desc(:date).paginate(page: params[:page], per_page: 10)
  end
end
