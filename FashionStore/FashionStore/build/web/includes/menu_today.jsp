
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/tinycarousel.css" type="text/css">
<script type="text/javascript" src="js/jquery.tinycarousel.js"></script>
<script type="text/javascript">
    $(document).ready(function ()
    {
        $('#slider1').tinycarousel({interval: true});
        var slider1 = $("#slider1").data("plugin_tinycarousel");
        slider1.start();
    });
</script>



</div>
</div>
