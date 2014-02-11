(function(cordova){

    'use strict';

    var exports = {},method;

    var plugin = {
        name:'TabBar',
        api:{
            'setup':{
                params:[],
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
                    props.params
                );
            };


        }(method,plugin.api[method]));

    }

    // expose
    if (!window.plugins) {window.plugins = {};}
    window.plugins[plugin.name.charAt(0).toLowerCase()] = exports;

}(window.cordova));