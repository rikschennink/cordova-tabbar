(function(cordova){

    'use strict';

    var exports = {},method;

    var plugin = {
        name:'TabBar',
        api:{
            'setup':null,
            'addTab':function(id,title,icon,onclick) {
                return {
                    params:[id,title,icon],
                    success:onclick || null,
                    failure:null
                };
            }
        }
    };

    for (method in plugin.api) {

        if (!plugin.api.hasOwnProperty(method)){continue;}

        exports[method] = (function(name,setup){

            return function() {

                var config = setup ? setup.apply(this,arguments) : {};

                cordova.exec(
                    config.success || null,
                    config.failure || null,
                    plugin.name,
                    name,
                    config.params || []
                );

            };

            /*
            return function() {

                cordova.exec(
                    props.success,
                    props.failure,
                    plugin.name,
                    method,
                    props.method ? props.method.apply(this,options) : []
                );

            };
            */

        }(method,plugin.api[method]));

    }

    // expose
    if (!window.plugins) {window.plugins = {};}
    window.plugins[plugin.name.charAt(0).toLowerCase() + plugin.name.slice(1)] = exports;

}(window.cordova));