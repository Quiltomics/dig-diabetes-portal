package org.broadinstitute.mpg
import grails.transaction.Transactional
import org.broadinstitute.mpg.diabetes.json.builder.LocusZoomJsonBuilder
import org.broadinstitute.mpg.diabetes.metadata.parser.JsonParser
import org.broadinstitute.mpg.diabetes.metadata.query.QueryJsonBuilder
import org.broadinstitute.mpg.diabetes.metadata.result.KnowledgeBaseFlatSearchTranslator
import org.broadinstitute.mpg.diabetes.metadata.result.KnowledgeBaseResultParser
import org.broadinstitute.mpg.diabetes.util.PortalException
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

@Transactional
class WidgetService {
    // instance variables
    JsonParser jsonParser = JsonParser.getService();
    QueryJsonBuilder queryJsonBuilder = QueryJsonBuilder.getQueryJsonBuilder();
    RestServerService restServerService;

    // setting variables
    private final String LOCUSZOOM_17K_ENDPOINT = "17k data";
    private final String LOCUSZOOM_HAIL_ENDPOINT_DEV = "Hail Dev";
    private final String LOCUSZOOM_HAIL_ENDPOINT_QA = "Hail QA";
    private String locusZoomEndpointSelection = LOCUSZOOM_HAIL_ENDPOINT_QA;
    private final List<String> locusZoomEndpointList = [this.LOCUSZOOM_17K_ENDPOINT, this.LOCUSZOOM_HAIL_ENDPOINT_DEV, LOCUSZOOM_HAIL_ENDPOINT_QA];

    // constants for now
    private final String dataSetKey = "ExSeq_17k_mdv2";
    private final String phenotypeKey = "T2D";
    private final String propertyKey = "P_FIRTH_FE_IV";
    private final String errorResponse = "{\"data\": {}, \"error\": true}";

    private String singleFilter ( String categorical, //
                                  String comparator,
                                  String propertyName,
                                  String propertyValue,
                                  String dataset
                                 ){
        String returnValue
        String operatorType
        String operator
        Boolean generateFilter = true;
        switch (categorical){
            case "0":
                operatorType = "FLOAT"
                break
            case "1":
                operatorType = "STRING"
                break
            case "2":
                operatorType = "INTEGER"
                break
            default: operatorType = "FLOAT"; break
        }
        switch (comparator){
            case "1":
                operator = "LT"
                break
            case "2":
                operator = "GT"
                break
            case "3":
                operator = "EQ"
                break
            default: operator = "LT"; break
        }
        switch (operatorType){
            case "FLOAT": break;
            case "INTEGER":
            case "STRING":
                if (propertyValue?.length()<1){
                    generateFilter = false
                } else { // currently we can only send in one value.
                    List <String> listOfSelectedValues = propertyValue.tokenize(",")
                    if (listOfSelectedValues.size()>1){
                        generateFilter = false
                    } else {
                        propertyValue = "\"${propertyValue}\""
                    }
                }
                break;
        }
        if (generateFilter){
            returnValue = """{"dataset_id": "${dataset}", "phenotype": "b", "operand": "${propertyName}", "operator": "${operator}", "value": ${propertyValue}, "operand_type": "${operatorType}"}""".toString()
        }else {
            returnValue=""
        }
        return returnValue
    }



    public String buildFilterDesignation (def filters,String dataset){
        String filterDesignation = ""

        if (filters.size()==0){
            filterDesignation =  """            "filters":    [
                ${singleFilter ( "1", "1", "ID", "ZZZZZ", dataset )}
            ]
""".toString()
        }
        else if (filters.size()> 1){
            List<String> requestedFilterList = []
            for (Map map in filters){
                if (map.name){
                     String proposedFilter = singleFilter ( map.cat, map.cmp, map.name, map.parm, dataset )
                    if (proposedFilter?.length()>1){
                        requestedFilterList << proposedFilter
                    }
                }
            }
            if (requestedFilterList.size()==0){
                filterDesignation =  """            "filters":    [
                 ${singleFilter ( "1", "1", "ID", "ZZZZZ", dataset )}
            ]
""".toString()
            } else {
                filterDesignation = """ "filters":    [
                ${requestedFilterList.join(",")}
        ]
""".toString()
            }

        } else {
            String operator = (filters.cmp[0]=="1") ? "LT" : "GT"
            String proposedFilter = singleFilter ( filters[0].cat, filters[0].cmp, filters[0].name, filters[0].parm, dataset ).trim()
            if (proposedFilter.size()==0){
                filterDesignation =  """            "filters":    [
                 ${singleFilter ( "1", "1", "ID", "ZZZZZ", dataset )}
            ]
""".toString()
            }else{
                filterDesignation = """ "filters":    [
                ${singleFilter ( filters[0].cat, filters[0].cmp, filters[0].name, filters[0].parm, dataset )}
        ]""".toString()
            }
        }

        return filterDesignation
    }



    public JSONObject getSampleDistribution( String dataset, List<String> requestedDataList, Boolean distributionRequested, def filters) {
        String filterDesignation = buildFilterDesignation (filters, dataset)
        String jsonGetDataString = """{
    "passback": "123abc",
    "entity": "variant",
    "page_number": 0,
    "limit": 18000,
    "count": false,
    "distribution": ${(distributionRequested)?'true':'false'},
    "bin_number": 24,
    "properties":    {
                           "cproperty": [],
                          "orderBy":    [],
"dproperty" : { ${requestedDataList.join(",")} } ,
      "pproperty" : { }} ,
       ${filterDesignation}
}""".toString()

        // submit the post request
        JSONObject jsonResultString = this.restServerService.postGetSampleDataCall(jsonGetDataString, RestServerService.SAMPLE_SERVER_URL_QA)

        // return
        return jsonResultString

    }
//    public JSONObject getSampleDistribution( JSONObject jsonObject) {
//        String dataset = jsonObject.dataset
//        JSONArray requestedData = jsonObject.requestedData as JSONArray
//        List<String> requestedDataList = []
//        for (Map map in requestedData){
//            if (map.name){
//                requestedDataList << """ "${map.name}":["${dataset}"]""".toString()
//            }
//        }
//
//        def filters = jsonObject.filters
//        String filterDesignation = buildFilterDesignation (filters, dataset)
//        String jsonGetDataString = """{
//    "passback": "123abc",
//    "entity": "variant",
//    "page_number": 0,
//    "count": false,
//    "distribution": true,
//    "bin_number": 24,
//    "properties":    {
//                           "cproperty": [],
//                          "orderBy":    [],
//"dproperty" : { ${requestedDataList.join(",")} } ,
//      "pproperty" : { }} ,
//       ${filterDesignation}
//}""".toString()
//
//        // submit the post request
//        JSONObject jsonResultString = this.restServerService.postGetSampleDataCall(jsonGetDataString, RestServerService.SAMPLE_SERVER_URL_QA)
//
//        // return
//        return jsonResultString
//
//    }




    public  JSONObject  getSampleList( JSONObject jsonObject) {
        // local variables
        JSONObject jsonResultString
        def filters = jsonObject.filters
        // apparently if the list contains one object then it is not returned is a list with one object, but as an object.  Come on -- really?
        String dataset = jsonObject.dataset
        JSONArray requestedData = jsonObject.requestedData
        String jsonGetDataString
        List<String> requestedDataList = []
        List<String> requestedFilterList = []

        for (Map map in requestedData){
            if (map.name){
                requestedDataList << """ "${map.name}":["${dataset}"]""".toString()
            }
        }
        requestedDataList << """ "ID":["${dataset}"]""".toString()
        String filterDesignation = ""
        if (filters.size()==0){
            filterDesignation =  """            "filters":    [
                    {"dataset_id": "${dataset}", "phenotype": "b", "operand": "ID", "operator": "LT", "value": "ZZZZZ", "operand_type": "STRING"}
                ]
""".toString()
        } else  if (filters.size()== 1) {
            String operator = (filters.cmp[0]=="1") ? "LT" : "GT"
            filterDesignation = """ "filters":    [
                    {"dataset_id": "${dataset}", "phenotype": "b", "operand": "${filters[0].name}", "operator": "${operator}", "value": ${filters[0].parm}, "operand_type": "FLOAT"}
            ]""".toString()
        }  else { // filters > 1
            for (Map map in filters){
                String operator = (map.cmp=="1") ? "LT" : "GT"
                if (map.name){
                    requestedFilterList << """{"dataset_id": "${dataset}", "phenotype": "b", "operand": "${map.name}", "operator": "${operator}", "value": ${map.parm}, "operand_type": "FLOAT"}""".toString()
                }
            }
            filterDesignation = """ "filters":    [
                    ${requestedFilterList.join(",")}
            ]
""".toString()
        }

        jsonGetDataString = """{
    "passback": "123abc",
    "entity": "variant",
    "page_number": 0,
    "limit": 2000,
    "count": false,
    "properties":    {
                           "cproperty": [],
                          "orderBy":    [],
"dproperty" : { ${requestedDataList.join(",")} } ,
      "pproperty" : { }} ,
       ${filterDesignation}
}""".toString()

        // submit the post request
        jsonResultString = this.restServerService.postGetSampleDataCall(jsonGetDataString, RestServerService.SAMPLE_SERVER_URL_QA)

        // return
        return jsonResultString
    }













    /**
     * returns a variant list for the LZ query
     *
     * @param chromosome
     * @param startPosition
     * @param endPosition
     * @return
     * @throws PortalException
     */
    public List<org.broadinstitute.mpg.diabetes.knowledgebase.result.Variant> getVariantListForLocusZoom(String chromosome, int startPosition, int endPosition, String dataset, String phenotype) throws PortalException {
        // local variables
        List<org.broadinstitute.mpg.diabetes.knowledgebase.result.Variant> variantList;
        String jsonResultString, jsonGetDataString;
        LocusZoomJsonBuilder locusZoomJsonBuilder = null;
        KnowledgeBaseResultParser knowledgeBaseResultParser;

        // build the LZ json builder
        locusZoomJsonBuilder = new LocusZoomJsonBuilder(dataset, phenotype);

        // get json getData query string
        jsonGetDataString = locusZoomJsonBuilder.getLocusZoomQueryString(chromosome, startPosition, endPosition);

        // submit the post request
        if (this.getLocusZoomEndpointSelection() == this.LOCUSZOOM_17K_ENDPOINT) {
            jsonResultString = this.restServerService.postGetDataCall(jsonGetDataString);

        } else if (this.getLocusZoomEndpointSelection() == this.LOCUSZOOM_HAIL_ENDPOINT_DEV) {
            jsonResultString = this.restServerService.postGetHailDataCall(jsonGetDataString, RestServerService.HAIL_SERVER_URL_DEV);

        } else if (this.getLocusZoomEndpointSelection() == this.LOCUSZOOM_HAIL_ENDPOINT_QA) {
            jsonResultString = this.restServerService.postGetHailDataCall(jsonGetDataString, RestServerService.HAIL_SERVER_URL_QA);

        } else {
            throw new PortalException("Got incorrect LZ endpoint selection: " + this.getLocusZoomEndpointSelection())
        }

        // translate the returning json into variant list
        knowledgeBaseResultParser = new KnowledgeBaseResultParser(jsonResultString);
        variantList = knowledgeBaseResultParser.parseResult();

        // return
        return variantList;
    }

    /**
     * returns a json string for the LZ query
     *
     * @param chromosome
     * @param startPosition
     * @param endPosition
     * @return
     */
    public String getVariantJsonForLocusZoomString(String chromosome, int startPosition, int endPosition, String dataset, String phenotype) {
        // local variables
        List<Variant> variantList = null;
        JSONObject jsonResultObject = null;
        KnowledgeBaseFlatSearchTranslator knowledgeBaseFlatSearchTranslator;
        String jsonResultString = null;

        if(dataset == null) {
            dataset = this.dataSetKey
        }
        if(phenotype == null) {
            phenotype = this.phenotypeKey
        }

        // get the query result and translate to a json string
        try {
            // get the variant list
            variantList = this.getVariantListForLocusZoom(chromosome, startPosition, endPosition, dataset, phenotype);

            // TODO: DIGP-354: Review property spoofing for Hail multiple phenotype call to see if appropriate
            // translate to json string
            knowledgeBaseFlatSearchTranslator = new KnowledgeBaseFlatSearchTranslator(dataset, "T2D", this.propertyKey);
            jsonResultObject = knowledgeBaseFlatSearchTranslator.translate(variantList);

            // translate to json string
            if (jsonResultObject != null) {
                jsonResultString = jsonResultObject.toString();
            } else {
                throw PortalException("got null json object for LZ search");
            }

        } catch (PortalException exception) {
            log.error("Got LZ getData query error: " + exception.getMessage());
            jsonResultString = this.errorResponse;
        }

        log.info("?!?!?!? ${jsonResultObject}")

        // return
        return jsonResultString;
    }

    public String getLocusZoomEndpointSelection() {
        return locusZoomEndpointSelection
    }

    /**
     * sets the LZ endpoint setting
     *
     * @param locusZoomEndpointSelection
     */
    void setLocusZoomEndpointSelection(String locusZoomEndpointSelection) {
        // log
        if (locusZoomEndpointSelection == this.LOCUSZOOM_17K_ENDPOINT) {
            log.info("now setting LZ endpoint to 17K dataset")

        } else if (locusZoomEndpointSelection == this.LOCUSZOOM_HAIL_ENDPOINT_DEV) {
            log.info("now setting LZ endpoint to Hail goT2D dataset")

        } else if (locusZoomEndpointSelection == this.LOCUSZOOM_HAIL_ENDPOINT_QA) {
            log.info("now setting LZ endpoint to Hail goT2D dataset")

        } else {
            log.error("now setting LZ endpoint to unknown: " + locusZoomEndpointSelection)
        }

        // set the endpoint setting
        this.locusZoomEndpointSelection = locusZoomEndpointSelection
    }

    public List<String> getLocusZoomEndpointList() {
        return locusZoomEndpointList
    }
}
