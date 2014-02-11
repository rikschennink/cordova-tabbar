(function(cordova){

    'use strict';

    var exports = {},method;

    var plugin = {
        name:'TabBar',
        api:{
            'setup':{
                method:null,
                success:null,
                failure:null
            },
            'addTab':{
                method:function(id,title,icon) {
                    return [id,title,icon];
                },
                success:null,
                failure:null
            }
        }
    };

    for (method in plugin.api) {

        if (!plugin.api.hasOwnProperty(method)){continue;}

        exports[method] = (function(method,props){

            return function() {
                cordova.exec(
                    props.success,
                    props.failure,
                    plugin.name,
                    method,
                    props.method ? props.method.apply(this,arguments) : []
                );
            };


        }(method,plugin.api[method]));

    }

    // expose
    if (!window.plugins) {window.plugins = {};}
    window.plugins[plugin.name.charAt(0).toLowerCase() + plugin.name.slice(1)] = exports;

}(window.cordova));