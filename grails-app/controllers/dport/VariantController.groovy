package dport

import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.web.json.JSONObject

class VariantController {
    RestServerService   restServerService

    def index() { }


    def variantInfo() {
        def slurper = new JsonSlurper()
        String geneToStartWith = params.id

       // JSONObject jsonObject =  restServerService.retrieveVariantInfoByName (geneToStartWith)
//        JSONObject jsonObject =  restServerService.retrieveVariantInfoByName (geneToStartWith)
//        LinkedHashMap hashMap =  restServerService.convertJsonToMap (jsonObject['variant-info'])


        render (view: 'variantInfo',
                      model:[variantToSearch: geneToStartWith,
                                         show_gwas:1,
                                         show_exchp: 1,
                                         show_exseq: 1,
                                         show_sigma: 0] )
    }
    def variantAjax() {
        String geneToStartWith = params.id

        JSONObject jsonObject =  restServerService.retrieveVariantInfoByName (geneToStartWith)
        render(status:200, contentType:"application/json") {
            [variant:jsonObject['variant-info']]
        }
    }

}
