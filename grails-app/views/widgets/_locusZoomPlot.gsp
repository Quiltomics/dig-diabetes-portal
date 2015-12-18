
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

        var mpgSoftware = mpgSoftware || {};

        mpgSoftware.locusZoom = (function () {

            function initLocusZoom() {
                // TODO - will need to test that incorrect input format doesn't throw JS exception which stops all JS activity
                // TODO - need to catch all exceptions to make sure rest of non LZ JS modules on page load properly (scope errors to this module)
                LocusZoom.populate();
            };

            // public routines are declared below
            return {
                initLocusZoom:initLocusZoom
            }

        }());

        $( document ).ready( function (){
            mpgSoftware.locusZoom.initLocusZoom();
        } );

    </script>

<div class="accordion-group">
    <div class="accordion-heading">
        <a class="accordion-toggle  collapsed" data-toggle="collapse" data-parent="#accordion3"
           href="#collapseLZ">
            <h2><strong><g:message code="gene.locusZoom.title" default="Locus Zoom"/></strong></h2>
        </a>
    </div>

    <div id="collapseLZ" class="accordion-body collapse">
        <div class="accordion-inner">
            <table border="0" cellspacing="10">
                <tr>
                    <td>
                        <div>
                                <b>Region: ${regionSpecification}</b>
                            <br>
                        </div>
                        <!-- TODO: get LZ canvas to dynamically resize to width of enclosing div and height to minimum possible for display -->
                        <div id="lz-1" class="lz-instance" data-region="${regionSpecification}"></div>
                    </td>
                </tr>
            </table>

        </div>
    </div>
</div>
