<div class="panel panel-default">
    <div class="panel-body">
        <div class="row clearfix">
            <div class="col-sm-12" style="text-align: left" style = "margin: 0 0 20px 0">
                <span id="filterInstructions" class="filterInstructions">Choose a phenotype to begin:</span>
            </div>
         </div>


        <div class="row clearfix">

           <div class="primarySectionSeparator">
                <div class="col-sm-offset-1 col-md-3" style="text-align: right">
                        Phenotype:
                </div>
               <div class="col-md-5">
                        <select name="" id="phenotype" class="form-control btn-group btn-input clearfix"
                                onchange="makeDataSetsAppear()">
                            <g:renderPhenotypeOptions/>
                        </select>

                </div>
               <div class="col-md-1">
                   <g:helpText title="variantSearch.wfRequest.phenotype.help.header" placement="right"
                               body="variantSearch.wfRequest.phenotype.help.text" qplacer="10px 0 0 0"/>
               </div>
               <div class="col-md-2">

               </div>
            </div>
        </div>

        <div class="row clearfix">

                <div class="primarySectionSeparator" id="dataSetChooser" style="display:none">
                    <div class="col-sm-offset-1 col-md-3" style="text-align: right">
                        Sample:
                    </div>
                    <div class="col-md-5">
                        <select name="" id="dataSet" class="form-control btn-group btn-input clearfix"
                                onchange="makeVariantFilterAppear()">
                        </select>

                    </span>

                    </div>
                    <div class="col-md-1">
                        <g:helpText title="variantSearch.wfRequest.dataSet.help.header" placement="right"
                                    body="variantSearch.wfRequest.dataSet.help.text" qplacer="10px 0 0 0"/>
                    </div>
                    <div class="col-md-2">

                    </div>


            </div>
        </div>

        <div class="row clearfix">

                <div class="primarySectionSeparator" id="variantFilter" style="display:none">

                    <div class="col-sm-offset-1 col-md-3" style="text-align: right; vertical-align: middle">
                        Filters:
                    </div>
                    <div class="col-md-6">
                        <div  style="margin-top: 20px" class="well well-sm">
                            <div class="row clearfix">
                                <div class="col-md-6">p Value</div>

                                <div class="col-md-4"><input type="text" class="form-control" id="pValue" style="height:24px"></div>
                                <div class="col-md-2">
                                    <g:helpText title="variantSearch.wfRequest.dataSet.help.header" placement="right"
                                                body="variantSearch.wfRequest.dataSet.help.text" qplacer="0 10px 0 0"/>
                                </div>

                            </div>

                            <div class="row clearfix" style="margin-top: 10px">
                                <div class="col-md-6">OR Value</div>

                                <div class="col-md-4"><input type="text" class="form-control" id="orValue" style="height:24px"></div>
                                <div class="col-md-2">
                                    <g:helpText title="variantSearch.wfRequest.dataSet.help.header" placement="right"
                                                body="variantSearch.wfRequest.dataSet.help.text" qplacer="0 10px 0 0"/>
                                </div>


                            </div>




                        </div>

                    </span>

                    </div>

                    <div class="col-md-2">

                    </div>

                    <div class="row clearfix" style="margin-top: 10px">
                        %{--<g:render template="variantEffectOnproteins" />--}%
                    </div>

                    <div>
                    </div>
                </div>

        </div>



        <button class="btn btn-lg btn-primary pull-right variant-filter-button" onclick="gatherFieldsAndPostResults()">Go</button>
    </div>
</div>