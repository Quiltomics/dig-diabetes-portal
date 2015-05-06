package dport

import dport.SharedToolsService

class VariantQueryToolsTagLib {

    SharedToolsService sharedToolsService


    def renderPhenotypeOptions = { attrs,body ->
        LinkedHashMap<String,List<LinkedHashMap>> map = sharedToolsService.composePhenotypeOptions()
        if (map){
            out <<  "<optgroup label='Cardiometabolic'>"
            List <Map> cardioList = map["cardio"]
            for (Map cardio in cardioList){
               String selectionIndicator = (cardio.mkey == 'T2D')?"  selected":""
               out <<  "<option value='${cardio.mkey}' ${selectionIndicator}>${cardio.name}</option>"
            }
            out <<  "</optgroup>"
            out << "<optgroup label='Other'>"
            List <Map> otherList = map["other"]
            for (Map other in otherList){
                out <<  "<option value='${other.mkey}'>${other.name}</option>"
            }
            out <<  "</optgroup>"
            out << body()
        }

    }


    def renderDatasetOptions = { attrs,body ->
        LinkedHashMap<String,List<LinkedHashMap>> map = sharedToolsService.composeDatasetOptions()
        if (map){
            out <<  "<optgroup label='Continental ancestry'>"
            List <Map> continentalAncestry = map["ancestry"]
            for (Map ancestry in continentalAncestry){
                out <<  "<option value='${ancestry.mkey}'>${ancestry.name}</option>"
            }
            out <<  "</optgroup>"
            out << body()
        }

    }

    def renderEncodedFilters = { attrs, body ->
        if ((attrs.filterSet) &&
                (attrs.filterSet.size() > 0)) {
            int blockCount = 0
            for (LinkedHashMap map in attrs.filterSet) {
                if (map.size()>0) {
                    out << """<div id="filterBlock${blockCount}" class="developingQueryComponentsBlockOfFilters">
                    <div class="variantWFsingleFilter">
                    <div class="row clearfix">
                    <div class="col-md-10">""".toString()
                    if (map.phenotype) {
                        out << """
                                <span class="phenotype">${map.phenotype}</span>
                    """.toString()

                    }
                    if (map.dataSet) {
                        out << """
                    <span class="dataset">${map.dataSet}</span>
                    """.toString()
                    }
                    if (map.orValue  || map.pValue) {


                            // a line to describe the odds ratio
                            if (map.orValue) {
                                out << """

                        <span class="cc">OR &gt;&nbsp;&nbsp; ${map.orValue}</span>
                                            """.toString()
                            }  // a single line for the odds ratio

                            // a line to describe the P value
                            if (map.pValue) {
                                out << """
                                                    <span class="dd">p-value &lt&nbsp;&nbsp; ${map.pValue}</span>
                            """.toString()
                            }// a single line for the P value

                    }  // the section containing all filters
                        out << """
                        </div>

                    <div class="col-md-2">
                       <span class="pull-right developingQueryComponentsFilterIcons" style="margin: 4px 10px 0 auto;">
                       <span class="glyphicon glyphicon-pencil filterEditor filterActivator" aria-hidden="true" id="editer${blockCount}"></span>
                       <span class="glyphicon glyphicon-plus-sign filterAdder filterActivator" aria-hidden="true" id="adder${blockCount}"></span>
                       <span class="glyphicon glyphicon-remove-circle filterCanceler filterActivator" aria-hidden="true" onclick="mpgSoftware.variantWF.removeThisClause(this)" id="remover${blockCount}"></span>
                    </span>
                    </div>
                    </div>

                    </div>
            </div>""".toString()
                            blockCount++;
                        }
                    }

                } else {
                    out << ""
                }
    }

    def renderHiddenFields = { attrs, body ->
        if ((attrs.filterSet) &&
                (attrs.filterSet.size() > 0)) {
            int blockCount = 0
            for (LinkedHashMap map in attrs.filterSet) {
                    if (map.size()>0){
                        String encodedFilterList = sharedToolsService.encodeAFilterList(
                                [phenotype:map.phenotype,
                                 dataSet:map.dataSet,
                                 orValue: map.orValue,
                                 orValueInequality: map.orValueInequality,
                                 pValue: map.pValue,
                                 pValueInequality: map.pValueInequality])
                        out << """<input type="text" class="form-control" id="savedValue${blockCount}" value="${
                            encodedFilterList
                        }" style="height:0px">""".toString()
                        blockCount++;
                    }
             }
            out << """<input type="text" class="form-control" id="totalFilterCount" value="${
                blockCount
            }" style="height:0px"></div>""".toString()
        }
    }



}
