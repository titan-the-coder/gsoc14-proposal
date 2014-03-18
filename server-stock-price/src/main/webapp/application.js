require(['dojox/cometd', 'dojo/dom', 'dojo/dom-construct', 'dojo/domReady!'],
function(cometd, dom, doc)
{
    cometd.configure({
        url: location.protocol + '//' + location.host + config.contextPath + '/cometd',
        logLevel: 'info'
    });

    cometd.addListener('/meta/handshake', function(message)
    {
        if (message.successful)
        {
            dom.byId('status').innerHTML += '<div>CometD handshake successful</div>';
            cometd.subscribe('/stock/*', function(message)
            {
                var data = message.data;
                var symbol = data.symbol;
                var value = data.newValue;
                
                window.data[symbol] = value;
                angular.element(document.getElementById(symbol)).scope().$apply(function(scope) { scope.data = window.data });
                updateChart(symbol, value);
            });
        }
        else
        {
            dom.byId('status').innerHTML += '<div>CometD handshake failed</div>';
        }
    });

    cometd.handshake();
});