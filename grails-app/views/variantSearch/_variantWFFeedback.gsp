<style>
.suggestions{
    font-size: 20px;
    color: red;
}
.bluebox{
    background-color: #add8e6;
    color: darkblue;
    padding: 20px;
}
</style>
<div class='suggestions'>
    <div class="row clearfix">
        <div class="col-sm-12">
            <span>Possible next steps:<span class='suggestionsVariable'>text goes here</span></span>
        </div>
    </div>
</div>
<div class='bluebox'>
    <div class="tab-pane fade in active developingQueryHolder" id="developingQuery">
        <g:renderEncodedFilters filterSet='${encodedFilterSets}'/>
    </div>
</div>