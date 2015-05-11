<style>
div.subtlePanelHeading {
    font-size: 10px;
    color: green;
    font-style: italic;
    font-decoration:none;
}
span.dataSetChoice{
    padding: 0 0 0 10px;
}
.dataSetOptions {
    margin: 0px 20px 0 20px;
}
.addFilterButton{
    background-color: #eee;
}
</style>

<script>
    function chgRadioButton(buttonLabel){
        if (buttonLabel ==='missense')  {
            $('#missense-options').show();
        }  else {
            $('#missense-options').hide();
        }
    };
</script>

<g:render template="variantWFFeedback" />

<div class="panel panel-default">

    <div class="panel-body">
        %{--<div class="row clearfix">--}%
            %{--<div class="col-sm-6" style="text-align: left" style="margin: 0 0 20px 0">--}%
                %{--<span id="filterInstructions" class="filterInstructions">Choose a phenotype to begin:</span>--}%
            %{--</div>--}%

            %{--<div class="col-sm-6" style="text-align: left" style="margin: 0 0 20px 0">--}%

                %{--<div class="panel-group" id="accordion">--}%
                    %{--<div class="dataSetOptions">--}%
                        %{--<div class="subtlePanelHeading">--}%
                            %{--<h4 class="panel-title">--}%
                                %{--<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"--}%
                                   %{--style="float: right;" title="By default search all data sets">Specify data set</a>--}%
                            %{--</h4>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%

            %{--</div>--}%
        %{--</div>--}%


        <div class="row clearfix">
            <div id="collapseOne" class="panel-collapse collapse">
                <div class="dataSetOptions">

                    <ul style="list-style-type: none;">
                        <li>
                            <input id="datasetExomeChip" type="checkbox" aria-label="Exome chip"
                                   value="datasetExomeChip"><span class="dataSetChoice">Exome chip</span>
                        </li>
                        <li>
                            <input id="datasetExomeSeq" type="checkbox" aria-label="Exome sequence"
                                   value="datasetExomeSeq"><span class="dataSetChoice">Exome sequence</span>
                        </li>
                        <li>
                            <input id="datasetGWAS" type="checkbox" aria-label="GWAS" value="datasetGWAS"><span
                                class="dataSetChoice">GWAS</span>
                        </li>
                    </ul>

                </div>
            </div>

        </div>

        <div class="row clearfix">
            %{--Here is the phenotype section--}%
            <div class="primarySectionSeparator">
                <div class="col-sm-offset-1 col-md-3" style="text-align: right">
                    trait or disease of interest:
                </div>

                <div class="col-md-5">
                    <select name="" id="phenotype" class="form-control btn-group btn-input clearfix"
                            onchange="mpgSoftware.firstResponders.respondToPhenotypeSelection()">
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
            %{--Here is the data set section--}%
            <div class="primarySectionSeparator" id="dataSetChooser" style="display:none">
                <div class="col-sm-offset-1 col-md-3" style="text-align: right">
                    data set:
                </div>

                <div class="col-md-5">
                    <select name="" id="dataSet" class="form-control btn-group btn-input clearfix"
                            onchange="mpgSoftware.firstResponders.respondToDataSetSelection()"
                            onclick="mpgSoftware.firstResponders.respondToDataSetSelection()">
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
        %{--Here is the drop-down that we will use to choose additional filters--}%
        <div class="primarySectionSeparator" id="additionalFilterSelection" style="display:none">
            <div class="col-sm-offset-1 col-md-3" style="text-align: right">
                <button type="button" class="btn btn-default btn-md addFilterButton"  onclick="mpgSoftware.firstResponders.requestToAddFilters()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;add additional filters:
                </button>
                %{--<button type="button" class="btn btn-default btn-lg"  onclick="console.log('wtf')">--}%
                     %{--<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;add additional filters:--}%
                %{--</button>--}%
            </div>

            <div class="col-md-5">
                <select name="additionalFilters" id="additionalFilters" size="3"
                        class="form-control btn-group btn-input clearfix">
                    <option value="pvalue" selected>p-value</option>
                    <option value="oddsratio">odds ratio</option>
                    <option value="effectsize">effect size</option>
                    <option value="gene">gene</option>
                    <option value="position">position</option>
                    <option value="predictedeffect">predicted effect on protein</option>
                    <option value="ethnicity">continental ancestry</option>
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



    <div id="filterHolder">

    </div>



        <span class="pull-right">
            <button class="btn btn-med btn-primary variant-filter-button"
                    onclick="mpgSoftware.variantWF.cancelThisFieldCollection()">Cancel</button>
            <button class="btn btn-med btn-primary variant-filter-button"
                    onclick="mpgSoftware.variantWF.gatherFieldsAndPostResults()">Build request &gt;&gt;</button>
        </span>

    </div>
</div>