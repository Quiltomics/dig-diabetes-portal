<style>
.suggestions{
    font-size: 20px;
    color: red;
    display:none;
}
.bluebox{
    background-color: #add8e6;
    color: darkblue;
    padding: 20px;
}
</style>
<div class='suggestions'>
    <div class="row clearfix" style="margin-bottom: 15px;">
        <div class="col-sm-12">
            <span>Possible next steps:&nbsp;<span class='suggestionsVariable'></span></span>
        </div>
    </div>
</div>
<div class='bluebox' tabindex='1'>
    <div class="tab-pane fade in active developingQueryHolder" id="developingQuery">
        <g:renderEncodedFilters filterSet='${encodedFilterSets}'/>
        <button class="btn btn-med btn-primary variant-filter-button pull-right"
                onclick="mpgSoftware.variantWF.launchAVariantSearch()">Submit search request</button>
    </div>
</div>
%{--<div id="headerWF"></div>--}%
%{--<div id="contentWF"></div>--}%
%{--<div id="footerWF"></div>--}%