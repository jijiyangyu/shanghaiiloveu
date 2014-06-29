// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function openAlert(text,wid,hei)
{
    Dialog.alert(text,
    {
        windowParameters: {
            width:wid,
            height:hei
        },
        okLabel: " ",
        ok: function(win) {
            if ($('site_video'))
                $('site_video').show();
        }
    });
}

function openConfirm(text,wid,hei,form)
{
    Dialog.confirm(text,
    {
        windowParameters: {
            width:wid,
            height:hei
        },
        okLabel: " ",
        cancelLabel: " ",
        ok: function(win) {
            form.submit();
            return false;
        },
        cancel: function(win) {
            return false;
        }
    });
}

function openAjaxConfirm(text,wid,hei,update,control,action,id,form)
{
    Dialog.confirm(text,
    {
        windowParameters: {
            width:wid,
            height:hei
        },
        okLabel: " ",
        cancelLabel: " ",
        ok: function(win) {
            Ajaxupdater(update,control,action,id,form);
            return false;
        },
        cancel: function(win) {
            return false;
        }
    });
}

function Ajaxupdater(update,control,action,id,form)
{
    var path='/'+control+'/'+action+'/'+id
    new Ajax.Updater(update, path, {
        asynchronous:true,
        evalScripts:true,
        parameters:Form.serialize(form)
    });
}

function enableField(id)
{
    var field = document.getElementById(id);
    field.disabled   =   !field.disabled;
}