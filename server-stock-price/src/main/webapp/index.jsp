<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <!-- The following is required by dojo to initialize the cometd setup -->
    <script data-dojo-config="async: true, tlmSiblingOfDojo: true, deps: ['application.js']"
            src="${pageContext.request.contextPath}/dojo/dojo.js.uncompressed.js"></script>
   
    <script type="text/javascript">
        var config = {
            contextPath: '${pageContext.request.contextPath}'
        };
        
        var data = {
          fbk: 125,
          ggl: 1199
        };
        
        // Config options
        var xVal = 0;
        var yVal = 100;	
        var updateInterval = 20;
        var dataLength = 500;
        
        // Chart objects
        var fbkChart;
        var gglChart;
        
        // Data objects
        var fbkData = [];
        var gglData = [];
  
        var updateChart = function (id, newValue) {
          var dps = window[id+"Data"];
          var chart = window[id+"Chart"];
          dps.push({
            x: xVal,
            y: newValue
          });
          xVal++;
          
          if (dps.length > dataLength)
          {
            dps.shift();				
          }
          chart.render();
        };
  
      window.onload = function () {
        fbkChart = new CanvasJS.Chart("fbkChartContainer",{
          title :{
            text: "Facebook Data:"
          },			
          data: [{
            type: "line",
            dataPoints: fbkData 
          }]
        });
        
        gglChart = new CanvasJS.Chart("gglChartContainer",{
          title :{
            text: "Google Data:"
          },			
          data: [{
            type: "line",
            dataPoints: gglData 
          }]
        });
      }
        
    </script>
    <!-- After this, everything is controlled by angularjs -->
    <title>MOTECH Dashboard - Angular JS</title>
</head>
<body>
  <div ng-app="">
  
    <h2>Dashboard using cometd and angularjs with activemq and tomcat integration</h2>
    <div id="status"></div>
    <div id="fbkChartContainer" style="height: 300px; width:100%;"></div>
    <span id='fbk'>{{"Facebook: " +data.fbk}}</span><br/>
    <div id="gglChartContainer" style="height: 300px; width:100%;"></div>
    <span id='ggl'>{{"Google: " +data.ggl}}</span>
    
  </div>
  <script type="text/javascript" src="canvasjs.min.js"></script>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.3/angular.min.js"></script>
</body>
</html>
