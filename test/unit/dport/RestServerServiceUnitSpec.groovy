package dport
import grails.test.mixin.TestFor
import spock.lang.Specification
import spock.lang.Unroll
import org.codehaus.groovy.grails.web.json.JSONObject

/**
 * Created by balexand on 7/18/2014.
 */
@Unroll
@TestFor(RestServerService)
class RestServerServiceUnitSpec extends Specification {

    void "test establish connection"() {
        when:
        String status = service.getServiceBody("http://grails.org/api/v1.0/plugin/acegi/")
        then:
        assertNotNull status
    }

    void "test retrieve Json"() {
        when:
        JSONObject jsonObject = service.getServiceJson("http://grails.org/api/v1.0/plugin/acegi/")
        then:
        assertNotNull jsonObject
    }



    void "test connection to diabetes server"() {
        given:
        String testJson = """{
"gene_symbol": "SLC30A8",
"columns": ["ID", "CHROM", "BEG", "END", "Function_description", "_13k_T2D_VAR_TOTAL", "_13k_T2D_ORIGIN_VAR_TOTALS", "_13k_T2D_lof_NVAR", "_13k_T2D_lof_MINA_MINU_RET",
"_13k_T2D_lof_METABURDEN", "_13k_T2D_GWS_TOTAL", "_13k_T2D_NOM_TOTAL", "EXCHP_T2D_VAR_TOTALS", "EXCHP_T2D_GWS_TOTAL", "EXCHP_T2D_NOM_TOTAL", "GWS_TRAITS",
"GWAS_T2D_GWS_TOTAL", "GWAS_T2D_NOM_TOTAL", "GWAS_T2D_VAR_TOTAL"],
"user_group": "ui"
}
""".toString()
        when:
        JSONObject jsonObject = service.postServiceJson("http://t2dgenetics.org/mysql/rest/server/gene-info",
                testJson)
        then:
        assertNotNull jsonObject
    }




    void "test retrieveGeneInfoByName"() {
        when:
        JSONObject jsonObject = service.retrieveGeneInfoByName("PANX1")
        then:
        assertNotNull jsonObject
    }

    void "test retrieveVariantInfoByName"() {
        when:
        JSONObject jsonObject = service.retrieveVariantInfoByName("rs13266634")
        then:
        assertNotNull jsonObject
    }


    void "test searchVariantInfoByName"() {
        when:
        JSONObject jsonObject = service.searchVariantInfoByName("rs13266634")
        then:
        assertNotNull jsonObject
    }


    void "test retrieveGenomicRegionByName"() {
        when:
        JSONObject jsonObject = service.searchGenomicRegionByName("junk")
        then:
        assertNotNull jsonObject
    }


    void "test retrieveGenomicRegionBySpecifiedRegion"() {
        when:
        JSONObject jsonObject = service.searchGenomicRegionBySpecifiedRegion(9,21940000,22190000)
        then:
        assertNotNull jsonObject
    }

    void "test retrieveGenomicRegionAsSpecifiedByUsers"() {
        when:
        JSONObject jsonObject = service.searchGenomicRegionAsSpecifiedByUsers("chr9:21,940,000-22,190,000")
        then:
        assertNotNull jsonObject
    }








}
