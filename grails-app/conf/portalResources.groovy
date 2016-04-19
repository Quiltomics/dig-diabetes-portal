modules = {
    jquery {
        resource url: 'js/lib/jquery-1.11.0.min.js'
        resource url: 'js/DataTables-1.10.7/media/js/jquery.dataTables.min.js'
        resource url: 'js/DataTables-1.10.7/media/css/jquery.dataTables.min.css'
        resource url: 'js/DataTables-1.10.7/extensions/TableTools/js/dataTables.tableTools.min.js'
        resource url: 'js/DataTables-1.10.7/extensions/TableTools/css/dataTables.tableTools.min.css'
        resource url: 'js/lib/jstree.min.js'
        resource url: 'https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'
    }
    scroller {
        resource url: 'js/lib/dport/jquery.li-scroller.1.0.js'
        resource url: 'css/lib/li-scroller.css'
    }
    portalHome {
        resource url: 'js/lib/dport/portalHome.js'
    }
    informational {
        resource url: 'js/lib/dport/informational.js'
    }
    traitInfo {
        resource url: 'css/dport/trait.css'
        resource url: 'js/lib/dport/trait.js'
    }
    sunburst {
        resource url: 'css/dport/sunburst.css'
        resource url: 'js/lib/dport/sunburst.js'
    }
    d3tooltip {
        resource url: 'js/lib/dport/d3tooltip.js'
        resource url: 'css/dport/d3tooltip.css'
    }
    manhattan {
        dependsOn "d3tooltip"

        resource url: 'js/lib/dport/manhattan.js'
        resource url: 'css/dport/manhattan.css'
    }
    crossMap {
        dependsOn "d3tooltip"

        resource url: 'js/lib/dport/crossMap.js'
    }
    phenotype {
        dependsOn "manhattan"

        resource url: 'js/lib/dport/phenotype.js'
    }
    geneInfo {
        resource url: 'css/dport/geneInfo.css'
        resource url: 'css/dport/barchart.css'

        resource url: 'js/lib/dport/geneInfo.js'
        resource url: 'js/lib/dport/barchart.js'

        resource url: 'js/lib/dport/igvLaunch.js'
    }
    variantInfo {
        dependsOn "core"

        resource url: 'css/images/controls.png'

        resource url: 'css/dport/barchart.css'
        resource url: 'css/dport/variant.css'
        resource url: 'css/lib/lightslider.css'

        resource url: 'js/lib/dport/variantInfo.js'
        resource url: 'js/lib/dport/barchart.js'
        resource url: 'js/lib/lightslider.js'

        resource url: 'js/lib/dport/igvLaunch.js'
    }
    variantWF {
        resource url: 'css/dport/variantWorkflow.css'
        resource url: 'js/lib/dport/variantWorkflow.js'
    }
    igv {
        dependsOn "jquery"

        resource url: 'images/ajaxLoadingAnimation.gif'

        resource url: 'https://data.broadinstitute.org/igvdata/web/beta/igv-beta.css'
        resource url: 'https://data.broadinstitute.org/igvdata/web/beta/igv-beta.min.js'
    }
    tableViewer {
        resource url: 'js/lib/dport/tableViewer.js'
        resource url: 'css/dport/tableViewer.css'
    }
    core {
        dependsOn "jquery"

        resource url: 'images/ajaxLoadingAnimation.gif'
        resource url: 'images/icons/dna-strands.ico'

        resource url: 'css/lib/bootstrap.min.css'

        resource url: 'css/lib/style.css'
        resource url: 'css/lib/dkstyle.css'

        resource url: 'js/lib/d3.min.js'
        resource url: 'js/lib/utils.js'

        resource url: 'js/lib/bootstrap3-typeahead.min.js'
        resource url: 'js/lib/shared.js'
        resource url: 'js/lib/tooltip.js'
        resource url: 'js/lib/popover.js'

        resource url: 'js/lib/lodash.js'

    }
    igvNarrow {  // IGV on a page with core
        resource url: 'http://www.broadinstitute.org/igvdata/t2d/igv-all.min.css'
        resource url: 'http://www.broadinstitute.org/igvdata/t2d/igv-all.min.js'
    }
    sigma {  // sigma site
        resource url: 'css/dport/sigma.css'
        resource url: 'js/lib/jquery-1.11.0.min.js'
    }

    mustache {
        resource url: 'js/lib/mustache.js'
    }
}

