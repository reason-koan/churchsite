CKEDITOR.editorConfig=function(e){e.language="en",e.format_tags="p;h1;h2;h3;h4;h5;h6;plead",e.format_plead={name:"Lead Paragraph",element:"p",attributes:{"class":"lead"}},e.toolbar=[{name:"clipboard",items:["Undo","Redo","-","Cut","Copy","Paste","PasteText","PasteFromWord"]},{name:"format",items:["Format","FontSize"]},{name:"basicstyles",items:["Bold","Italic","Underline","TextColor","BGColor"]},{name:"indent",items:["Indent","Outdent","NumberedList","BulletedList"]},{name:"alignment",items:["JustifyLeft","JustifyCenter","JustifyRight","JustifyBlock"]},{name:"insert",items:["Link","Unlink","Image","Table","SpecialChar"]},{name:"editing",items:["Find","Replace"]},{name:"spelling",items:["Scayt"]},{name:"maximize",items:["Maximize"]}],e.filebrowserBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",e.filebrowserImageBrowseUrl="/ckeditor/pictures",e.filebrowserImageUploadUrl="/ckeditor/pictures",e.filebrowserUploadUrl="/ckeditor/attachment_files",e.filebrowserParams=function(){for(var e,t,a,i=document.getElementsByTagName("meta"),r=new Object,n=0;n<i.length;n++)switch(a=i[n],a.name){case"csrf-token":e=a.content;break;case"csrf-param":t=a.content;break;default:continue}return void 0!==t&&void 0!==e&&(r[t]=e),r},e.addQueryString=function(e,t){var a=[];if(!t)return e;for(var i in t)a.push(i+"="+encodeURIComponent(t[i]));return e+(-1!=e.indexOf("?")?"&":"?")+a.join("&")},CKEDITOR.on("dialogDefinition",function(t){var a,i,r=t.data.name,n=t.data.definition;CKEDITOR.tools.indexOf(["link","image","attachment","flash"],r)>-1&&(a=n.getContents("Upload")||n.getContents("upload"),i=null==a?null:a.get("upload"),i&&i.filebrowser&&void 0===i.filebrowser.params&&(i.filebrowser.params=e.filebrowserParams(),i.action=e.addQueryString(i.action,i.filebrowser.params)))})};