
    <!--
    <script src="https://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    -->

    <script src="http://portaldev.sph.umich.edu/lzplug/assets/js/locuszoom.vendor.min.js" type="text/javascript"></script>
    <script src="http://portaldev.sph.umich.edu/lzplug/assets/js/locuszoom.app.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="http://portaldev.sph.umich.edu/lzplug/assets/css/locuszoom.css"/>

    <script type="text/javascript">
        LocusZoom.DefaultDataSources = {
            position: new LocusZoom.Data.AssociationSource("http://portaldev.sph.umich.edu/api_internal_dev/v1/single/"),
            ld: new LocusZoom.Data.LDSource("http://portaldev.sph.umich.edu/api_internal_dev/v1/pair/LD/"),
            gene: new LocusZoom.Data.GeneSource("http://portaldev.sph.umich.edu/api_internal_dev/v1/annotation/genes/")
        };

        var topHits = [
            ["16:53819169", "FTO"],
            ["9:22051670", "CDKN2A/B"],
            ["7:28196413", "JAZF1"],
            ["19:33909710", "PEPD"],
            ["19:46158513", "GIPR"],
            ["12:71433293", "TSPAN8/LGR5"],
            ["10:114758349", "TCF7L2"],
            ["8:95937502", "TP53INP1"],
            ["2:27741237", "GCKR"],
            ["6:20679709", "CDKAL1"],
            ["2:161346447", "RBMS1"],
            ["16:75247245", "BCAR1"],
            ["15:77832762", "HMG20A"],
            ["7:15052860", "DGKB"],
            ["5:76427311", "ZBED3"] ];

        // Apply form data to a remapping of a LocusZoom object
        function handleFormSubmit(lz_id){
            //var chr   = $("#" + lz_id + "_chr")[0].value;
            //var start = $("#" + lz_id + "_start")[0].value;
            //var end   = $("#" + lz_id + "_end")[0].value;
            var target =  $("#" + lz_id + "_region")[0].value.split(":");
            var chr = target[0];
            var pos = target[1];
            var start = 0;
            var end = 0;
            if ( pos.match(/[-+]/) ) {
                if (pos.match(/[-]/)) {
                    pos = pos.split("-");
                    start = +pos[0];
                    end = +pos[1];
                } else {
                    pos = pos.split("+");
                    start = (+pos[0]) - (+pos[1]);
                    end = (+pos[0]) + (+pos[1]);
                }

            } else {
                start = +pos - 300000
                end = +pos + 300000
            }
            LocusZoom._instances[lz_id].mapTo(chr, start, end);
        }

        function jumpTo(region, lz_id) {
            lz_id = lz_id || "lz-1";
            var target = region.split(":");
            var chr = target[0];
            var pos = target[1];
            var start = 0;
            var end = 0;
            if ( pos.match(/[-+]/) ) {

            } else {
                start = +pos - 300000
                end = +pos + 300000
            }
            LocusZoom._instances[lz_id].state.ldrefvar = "";
            LocusZoom._instances[lz_id].mapTo(chr, start, end);
            populateForms();
            return(false);
        }

        // Fill demo forms with values already loaded into LocusZoom objects
        function populateForms(){
            d3.selectAll("div.lz-instance").each(function(){
                $("#" + this.id + "_region")[0].value = LocusZoom._instances[this.id].state.chr +
                        ":" + LocusZoom._instances[this.id].state.start +
                        "-" + LocusZoom._instances[this.id].state.end;

            });
        }

        function listHits() {
            $("#tophits").empty().append("<ul>").children(0).append(topHits.map(function(e) {
                return "<li><a href='javascript:jumpTo(\"" + e[0] + "\");'>" + e[1] + " </a></li>";
            }))
        }

        function initPage() {
            // listHits();
            LocusZoom.populate();
            populateForms();
            $("#lz-1_hits").html(topHits.map(function(k) {return "<option>" + k + "</option>"}).join(""));
        };

    </script>
</head>
<body style="background-color: #CCCCCC; margin: 10px;" onload="initPage()">
<table border="0" cellspacing="10">
    <tr>
        <td>
            <div>
                <form>
                    <b>lz-1</b> &middot;
                    <label for="lz-1_region">Region: </label>
                    <input type="text" size=25 id="lz-1_region">
                    <input type="button" id="lz-1_submit" value="Go" onClick="handleFormSubmit('lz-1');" />
                </form>
                <br>
            </div>
            <div id="lz-1" class="lz-instance" data-region="${regionSpecification}"></div>
        </td>
        <td style="vertical-align:top">
            <div id="tophits">${regionSpecification}</div>
        </td>
    </tr>
</table>
