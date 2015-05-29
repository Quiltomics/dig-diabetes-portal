var mpgSoftware = mpgSoftware || {};


(function () {
    "use strict";


    mpgSoftware.variantWF = (function () {
        // private variables
        var currentInteractivity = 1, // 0->defining a filter, 1-> potentially manipulating our  list of existing filters
        activeColor = '#0008b',
        inactiveColor = '#808080';

        /***
         * private methods
         * @param indexNumber
         */

        /***
         *   true implies emphasize blue box and deemphasize clause development area.
         *   False implies deemphasize blue box and emphasize clause development area.
         */
        var emphasizeBlueBox = function(hoorayBlueBox){
            if(hoorayBlueBox){
                $('.bluebox').addClass('inputGoesHere');
                $('.panel').removeClass('inputGoesHere');
            }else {
                $('.panel').addClass('inputGoesHere');
                $('.bluebox').removeClass('inputGoesHere');
            }

        };
        /***
         * add standard state dependent message unless there is an override text (and then display the override)
         */
        var whatToDoNext = function(state, override){
            var suggestionField = $('.suggestionsVariable');
            if (typeof override !== 'undefined') {
                suggestionField.text (override);
            }else {
                switch (state){
                    case 0:
                        suggestionField.text ('Choose a trait from the drop-down box');
                        break;
                    case 1:
                        suggestionField.text ('Choose one of the available data sets');
                        break;
                    case 2:
                        suggestionField.text ('Add additional filters, or else click Build request button');
                        break;
                    case 3:
                        suggestionField.text ('Editing existing clause.');
                        break;
                    case 101:
                        suggestionField.text ('Clause added.  You may edit, or remove a clause in the blue box, or else begin building an additional clause in the white box.');
                        break;
                    case 102:
                        suggestionField.text ('Clause canceled.  You may edit, or remove a clause in the blue box, or else begin building an additional clause in the white box.');
                        break;
                    default:
                        suggestionField.text ('');
                        break;
                }
            }
        };


        var existingFiltersManipulators = function(x){ // 0 deactivates, 1 activates
            var filterActivator = $('.filterActivator');
            if (x){
                emphasizeBlueBox(true);
                filterActivator.css('color',activeColor);
                filterActivator.css('cursor', 'pointer');
            }else {
                emphasizeBlueBox(false);
                filterActivator.css('color',inactiveColor);
                filterActivator.css('cursor', 'default');
            }
        };
        var numberExistingFilters = function (x){
            var filterCount = $('#totalFilterCount');
            var returnValue = 0;
            if (!arguments.length) {//no argument, this is a getter call
                if (typeof filterCount !== 'undefined') {
                    returnValue =  parseInt (filterCount.attr('value'));
                }
            } else {// we received an argument, treat this as a setter
                if (typeof filterCount !== 'undefined') {
                    filterCount.attr('value',x)
                }
            }
            return returnValue;
        };
         var handleBlueBoxVisibility = function (){
            var blueBox = $('.bluebox');
            if (numberExistingFilters() > 0){
                blueBox.show();
            } else {
                blueBox.hide();
            }
        };
         // getter/setter.
        // 0 === we are working on a single filter
        // 1 === all of the existing filters can be manipulated, since single filter is not in play
        var currentInteractivityState = function(newValue){
            if (!arguments.length) return currentInteractivity;
           // if (currentInteractivity  !==  newValue){ // the state of things is changing. Make sure the interface is up-to-date
                existingFiltersManipulators (newValue);
           // }
        };
        var forgetThisFilter = function  (indexNumber){
            if(typeof indexNumber !== 'undefined'){
                $('#savedValue'+indexNumber).remove ();
                $('#filterBlock'+indexNumber).remove ();
            }
        };
        var instantiatePhenotype = function (value) {
            $('#phenotype').val(value)
        };
        var instantiateInputFields = function (clauseDefinition){
            var extractString = function (fullString,marker){
                var startIndex = fullString.indexOf(marker)+marker.length;
                var remainingString = fullString.substr(startIndex);
                var endIndex = remainingString.indexOf('^');
                return fullString.substr(startIndex,endIndex);
            };
            if (typeof clauseDefinition  !== 'undefined') {
                var filters = clauseDefinition.split("^");
                for ( var i = 0 ; i < filters.length ; i++ ){
                    var oneFilter = filters [i];
                    if (oneFilter){
                        var fieldVersusValue =  oneFilter.split("=");
                        if (fieldVersusValue.length === 2 ){
                            switch (fieldVersusValue[0]) {
                                case '1':instantiatePhenotype (fieldVersusValue[1]);
                                    break;
                                case '2':mpgSoftware.firstResponders.displayDataSetChooser(fieldVersusValue[1]);
                                    break;
                                case '3': // There are two fields we need to handle here.  Let's pull out the other one by hand
                                    mpgSoftware.firstResponders.respondToReviseFilters('oddsratio',extractString (clauseDefinition,'^4='),fieldVersusValue[1]);
                                    break;// or value and or inequality are handled together, so skip one
                                case '4':break;// Ignore
                                case '5': // There are two fields we need to handle here.  Let's pull out the other one by hand
                                    mpgSoftware.firstResponders.respondToReviseFilters('pvalue',extractString (clauseDefinition,'^6='),fieldVersusValue[1]);
                                    break;// or value and or inequality are handled together, so skip one
                                case '6':break;
                                case '7':mpgSoftware.firstResponders.respondToReviseFilters('gene',fieldVersusValue[1]);
                                    break;
                                case '8':break;//  chromosome name, handled under 10
                                case '9':break;// chromosome start, handled under 10
                                case '10': // chromosome end -- handle a chromosome here
                                    mpgSoftware.firstResponders.respondToReviseFilters('position',extractString (clauseDefinition,'^9='),fieldVersusValue[1],extractString (clauseDefinition,'^8='));
                                    break;
                                case '11':
                                    mpgSoftware.firstResponders.respondToReviseFilters('predictedeffect',fieldVersusValue[1],extractString (clauseDefinition,'^14='),extractString (clauseDefinition,'^15='),extractString (clauseDefinition,'^16='));
                                    break;
                                case '12': // There are two fields we need to handle here.  Let's pull out the other one by hand
                                    mpgSoftware.firstResponders.respondToReviseFilters('effectsize',extractString (clauseDefinition,'^13='),fieldVersusValue[1]);
                                    break;// or value and or inequality are handled together, so skip one
                                case '14':break;//  chromosome name, handled under 11
                                case '15':break;//  chromosome name, handled under 11
                                case '16':break;//  chromosome name, handled under 11
                                default: break;
                            }
                        }

                    }

                }
            }
        };
        var makeClauseCurrent = function (indexNumber) {
            if (typeof indexNumber !== 'undefined') {
                var codedFilters = $('#savedValue'+indexNumber).val();
                if (typeof codedFilters  !== 'undefined'){
                    instantiateInputFields (codedFilters);
                }
            }
        };
        var retrievePhenotypes = function () {
            var loading = $('#spinner').show();
            $.ajax({
                cache: false,
                type: "post",
                url: "./retrievePhenotypesAjax",
                data: {},
                async: true,
                success: function (data) {
                    if (( data !==  null ) &&
                        ( typeof data !== 'undefined') &&
                        ( typeof data.datasets !== 'undefined' ) &&
                        (  data.datasets !==  null ) ) {
                        fillPhenotypeDropdown(data.datasets);
                    }
                    loading.hide();
                },
                error: function (jqXHR, exception) {
                    loading.hide();
                    core.errorReporter(jqXHR, exception);
                }
            });
        };

        var retrieveDataSets = function (phenotype, experiment) {
            var loading = $('#spinner').show();
            $.ajax({
                cache: false,
                type: "post",
                url: "./retrieveDatasetsAjax",
                data: {phenotype: phenotype,
                    experiment:experiment},
                async: true,
                success: function (data) {
                    if (( data !==  null ) &&
                        ( typeof data !== 'undefined') &&
                        ( typeof data.datasets !== 'undefined' ) &&
                        (  data.datasets !==  null ) ) {
                        fillDataSetDropdown(data.datasets);
                    }
                    loading.hide();
                },
                error: function (jqXHR, exception) {
                    loading.hide();
                    core.errorReporter(jqXHR, exception);
                }
            });
        };
        var retrievePropertiesPerDataSet = function (phenotype,dataset) {
            var loading = $('#spinner').show();
            $.ajax({
                cache: false,
                type: "post",
                url: "./retrievePropertiesAjax",
                data: {phenotype: phenotype,dataset: dataset},
                async: true,
                success: function (data) {
                    if (( data !==  null ) &&
                        ( typeof data !== 'undefined') &&
                        ( typeof data.datasets !== 'undefined' ) &&
                        (  data.datasets !==  null ) ) {
                        fillPropertiesDropdown(data.datasets);
                    }
                    loading.hide();
                },
                error: function (jqXHR, exception) {
                    loading.hide();
                    core.errorReporter(jqXHR, exception);
                }
            });
        };

        var extractIndex = function (idLabel,currentObject){
            var filterIndex = -1;
            var id = $(currentObject).attr ('id');
            var desiredLocation = id.indexOf (idLabel);
            if ((desiredLocation > -1) &&
                (typeof id !== 'undefined') ){
                var filterIndexString = id.substring(id.indexOf(idLabel)+ idLabel.length);
                filterIndex = parseInt(filterIndexString);
            }
            return filterIndex;
        };


        /***
         * public methods
         * @param currentObject
         */


        var removeThisClause = function (currentObject){
            if (currentInteractivityState()){
                var filterIndex = extractIndex ('remover',currentObject);
                forgetThisFilter (filterIndex);
                numberExistingFilters(numberExistingFilters()-1);
                handleBlueBoxVisibility ();
                whatToDoNext(102);

            }
        };
        var editThisClause = function (currentObject){
            if (currentInteractivityState()){
                var filterIndex = extractIndex ('editor',currentObject);
                makeClauseCurrent (filterIndex);
                forgetThisFilter (filterIndex);
                numberExistingFilters(numberExistingFilters()-1);
                handleBlueBoxVisibility ();
                $('#additionalFilterSelection').show ();
                whatToDoNext(3);
            }
        };
        var removeThisFilter = function (currentObject){
            if (typeof currentObject !== 'undefined') {
                var currentObjectId = currentObject.id;
                var targetName = currentObjectId.split("_")[1];
                var target = $('#'+targetName);
                if (typeof target !== 'undefined')  {
                    target.remove ();
                }
            }
         };
        var fillDataSetDropdown = function (dataSetJson) { // help text for each row
            if ((typeof dataSetJson !== 'undefined')  &&
                (typeof dataSetJson["is_error"] !== 'undefined')&&
                (dataSetJson["is_error"] === false))
            {
                var numberOfRecords = parseInt (dataSetJson ["numRecords"]);
                var options = $("#dataSet");
                options.empty();
                var dataSetList = dataSetJson ["dataset"];
                for ( var i = 0 ; i < numberOfRecords ; i++ ){
                    options.append($("<option />").val(dataSetList[i]).text(dataSetList[i]));
                }
            }
        };
        var fillPhenotypeDropdown = function (dataSetJson) { // help text for each row
            if ((typeof dataSetJson !== 'undefined')  &&
                (typeof dataSetJson["is_error"] !== 'undefined')&&
                (dataSetJson["is_error"] === false))
            {
                var numberOfRecords = parseInt (dataSetJson ["numRecords"]);
                var options = $("#phenotype");
                options.empty();
                var dataSetList = dataSetJson ["dataset"];
                for ( var i = 0 ; i < numberOfRecords ; i++ ){
                    options.append($("<option />").val(dataSetList[i]).text(dataSetList[i]));
                }
            }
        };
        var fillPropertiesDropdown = function (dataSetJson) { // help text for each row
            if ((typeof dataSetJson !== 'undefined')  &&
                (typeof dataSetJson["is_error"] !== 'undefined')&&
                (dataSetJson["is_error"] === false))
            {
                var numberOfRecords = parseInt (dataSetJson ["numRecords"]);
                var options = $("#additionalFilters");
                options.empty();
                var dataSetList = dataSetJson ["dataset"];
                for ( var i = 0 ; i < numberOfRecords ; i++ ){
                    options.append($("<option />").val(dataSetList[i]).text(dataSetList[i]));
                }
            }
        };
        var gatherFieldsAndPostResults = function (){
            var varsToSend = {};
            var phenotypeInput = UTILS.extractValsFromCombobox(['phenotype']);
            var datasetInput = UTILS.extractValsFromCombobox(['dataSet']);
            var pvEquivalence = UTILS.extractValsFromCombobox(['pvEquivalence']);
            var orEquivalence = UTILS.extractValsFromCombobox(['orEquivalence']);
            var esEquivalence = UTILS.extractValsFromCombobox(['esEquivalence']);
            var variantFilters = UTILS.extractValFromTextboxes(['pvValue','orValue','esValue']);
            var totalFilterCount = UTILS.extractValFromTextboxes(['totalFilterCount']);
            var experimentChoice = UTILS.extractValFromCheckboxes(['datasetExomeChip','datasetExomeSeq','datasetGWAS']);
            var restrictToRegion = UTILS.extractValFromTextboxes(['region_gene_input','region_chrom_input','region_start_input','region_stop_input']);
            var missensePredictions = [];
            varsToSend["predictedEffects"]  = $("input:radio[name='predictedEffects']:checked").val();
            if (varsToSend["predictedEffects"]==='missense'){
                missensePredictions = UTILS.extractValsFromCombobox(['polyphenSelect','siftSelect','condelSelect']);
            }
            var savedValuesList = [];
            var savedValue = {};
            if (typeof totalFilterCount['totalFilterCount'] !== 'undefined') {
                var valueCount = parseInt(totalFilterCount['totalFilterCount']);
                if (valueCount>0){
                    for ( var i = 0 ; i < valueCount ; i++ ){
                        savedValuesList.push ('savedValue'+i);
                    }
                    savedValue = UTILS.extractValFromTextboxes(savedValuesList);
                }
            }
            //var savedValue = UTILS.extractValFromTextboxes(['savedValue']);
            varsToSend = UTILS.concatMap(varsToSend,restrictToRegion) ;
            varsToSend = UTILS.concatMap(varsToSend,missensePredictions) ;
            varsToSend = UTILS.concatMap(varsToSend,phenotypeInput) ;
            varsToSend = UTILS.concatMap(varsToSend,datasetInput) ;
            varsToSend = UTILS.concatMap(varsToSend,pvEquivalence) ;
            varsToSend = UTILS.concatMap(varsToSend,orEquivalence) ;
            varsToSend = UTILS.concatMap(varsToSend,esEquivalence) ;
            varsToSend = UTILS.concatMap(varsToSend,variantFilters) ;
            varsToSend = UTILS.concatMap(varsToSend,savedValue) ;
            varsToSend = UTILS.concatMap(varsToSend,experimentChoice) ;
            UTILS.postQuery('./variantVWRequest',varsToSend);
        };
        var cancelThisFieldCollection = function (){
            var varsToSend = {};
            var savedValue = {};
            var savedValuesList = [];
            var totalFilterCount = UTILS.extractValFromTextboxes(['totalFilterCount']);
            if (typeof totalFilterCount['totalFilterCount'] !== 'undefined') {
                var valueCount = parseInt(totalFilterCount['totalFilterCount']);
                if (valueCount>0){
                    for ( var i = 0 ; i < valueCount ; i++ ){
                        savedValuesList.push ('savedValue'+i);
                    }
                    savedValue = UTILS.extractValFromTextboxes(savedValuesList);
                }
            }
            varsToSend = UTILS.concatMap(varsToSend,savedValue) ;
            UTILS.postQuery('./variantVWRequest',varsToSend);
        };
        var launchAVariantSearch = function (){
            var varsToSend = {};
            var savedValuesList = [];
            var savedValue = {};
            var totalFilterCount = UTILS.extractValFromTextboxes(['totalFilterCount']);
            if (typeof totalFilterCount['totalFilterCount'] !== 'undefined') {
                var valueCount = parseInt(totalFilterCount['totalFilterCount']);
                if (valueCount>0){
                    for ( var i = 0 ; i < valueCount ; i++ ){
                        savedValuesList.push ('savedValue'+i);
                    }
                    savedValue = UTILS.extractValFromTextboxes(savedValuesList);
                }
            }
            varsToSend = UTILS.concatMap(varsToSend,savedValue) ;
            UTILS.postQuery('./launchAVariantSearch',varsToSend);
        };

        var initializePage = function (){
            if (numberExistingFilters() > 0){
                handleBlueBoxVisibility ();
                currentInteractivityState(1);
                whatToDoNext(101);
                emphasizeBlueBox(true);
            } else {
                handleBlueBoxVisibility ();
                currentInteractivityState(0);
                whatToDoNext(0);
                emphasizeBlueBox(false);
            }
            retrievePhenotypes();
//            $("#phenotype").prepend("<option value='' selected='selected'></option>");

        };
        return {
            cancelThisFieldCollection:cancelThisFieldCollection,
            fillDataSetDropdown:fillDataSetDropdown,
            fillPropertiesDropdown:fillPropertiesDropdown,
            gatherFieldsAndPostResults:gatherFieldsAndPostResults,
            launchAVariantSearch:launchAVariantSearch,
            initializePage:initializePage,
            removeThisClause:removeThisClause,
            editThisClause:editThisClause,
            removeThisFilter:removeThisFilter,
            existingFiltersManipulators:existingFiltersManipulators,
            currentInteractivityState:currentInteractivityState,
            retrievePhenotypes:retrievePhenotypes,
            retrieveDataSets:retrieveDataSets,
            retrievePropertiesPerDataSet:retrievePropertiesPerDataSet,
            whatToDoNext:whatToDoNext
        }

    }());





















    /***
     * lots of callbacks, and other methods that respond directly to user interaction
     */
    mpgSoftware.firstResponders = (function () {
        /***
         * private
         */
        var appendValueWithEquivalenceChooser = function (currentDiv,holderId,sectionName,equivalenceId,valueId,helpTitle,helpText,equivalence,defaultValue){
            var lessThanSelected = '';
            var greaterThanSelected = '';
            if (typeof equivalence !== 'undefined'){
                if (equivalence === 'lessThan'){
                    lessThanSelected = "selected";
                } else {
                    greaterThanSelected = "selected";
                }
            }
            currentDiv.append("<div id='"+holderId+"' class='row clearfix'>"+
                "<div class='primarySectionSeparator'>"+
                "<div class='col-sm-offset-1 col-md-3' style='text-align: right'>"+sectionName+"</div>"+
                "<div class='col-md-2'>"+
                "<select id='"+equivalenceId+"' class='form-control btn-group btn-input clearfix'>"+
                "<option "+lessThanSelected+" value='lessThan'>&lt;</option>"+
                "<option "+greaterThanSelected+" value='greaterThan'>&gt;</option>"+
                "</select>"+
                "</div>"+
                "<div class='col-md-3'><input type='text' class='form-control' id='"+valueId+"'></div>"+
                "<div class='col-md-1'>"+
                "<span style='padding:10px 0 0 0' class='glyphicon glyphicon-question-sign pop-right' aria-hidden='true' data-toggle='popover' animation='true' "+
                "trigger='hover' data-container='body' data-placement='right' title='' data-content='"+helpText + "' data-original-title='"+helpTitle + "'></span>"+
                "</div>"+
                "<div class='col-md-2'>"+
                "<span class='glyphicon glyphicon-remove-circle filterCanceler filterRefiner' aria-hidden='true' onclick='mpgSoftware.variantWF.removeThisFilter(this)' id='remove_"+holderId+"'></span>"+
                "</div>"+
                "</div>");
            if (typeof defaultValue !== 'undefined'){
                $('#'+valueId).val(defaultValue);
            }
        };


        var appendGeneChooser = function (currentDiv,holderId,sectionName,geneInputId,helpTitle,helpText,geneName){
            currentDiv.append("<div id='"+holderId+"' class='row clearfix'>"+
                "<div class='primarySectionSeparator'>"+
                "<div class='col-sm-offset-1 col-md-3' style='text-align: right'>"+sectionName+"</div>"+
                "<div class='col-md-5'>"+
                "<input type='text' class='form-control' id='region_gene_input' style='display: inline-block'/>"+
                "</div>"+
                "<div class='col-md-1'>"+
                "<span style='padding:10px 0 0 0' class='glyphicon glyphicon-question-sign pop-right' aria-hidden='true' data-toggle='popover' animation='true' "+
                "trigger='hover' data-container='body' data-placement='right' title='' data-content='"+helpText + "' data-original-title='"+helpTitle + "'></span>"+
                "</div>"+
                "<div class='col-md-2'>"+
                "<span class='glyphicon glyphicon-remove-circle filterCanceler filterRefiner' aria-hidden='true' onclick='mpgSoftware.variantWF.removeThisFilter(this)' id='remove_"+holderId+"'></span>"+
                "</div>"+
                "</div>");
            if (typeof geneName !== 'undefined'){
                $('#region_gene_input').val(geneName);
            }

        };


        var appendPositionChooser = function (currentDiv,holderId,sectionName,chromosomeId,startHere,endHere,helpTitle,helpText,startingExtent,endingExtent,chromosomeName){
            currentDiv.append("<div id='"+holderId+"' class='row clearfix'>"+
                "<div class='primarySectionSeparator'>"+
                "<div class='col-sm-offset-1 col-md-3' style='text-align: right'>"+sectionName+"</div>"+
                "<div class='col-md-5'>"+
                    "<div class='row'>"+
                        "<div class='col-xs-4'>"+
                            "<input class='form-control' type='text' id='" + chromosomeId+ "' placeholder='chrom'/>"+
                        "</div>"+
                        "<div class='col-xs-1'></div>"+
                        "<div class='col-xs-3'>"+
                            "<input class='form-control' type='text' id='" + startHere+ "' style='display: inline-block' placeholder='start'/>"+
                        "</div>"+
                        "<div class='col-xs-1'></div>"+
                        "<div class='col-xs-3'>"+
                            "<input class='form-control' type='text' id='" + endHere+ "' style='display: inline-block' placeholder='stop'/>"+
                        "</div>"+
                    "</div>"+
                "</div>"+
                "<div class='col-md-1'>"+
                    "<span style='padding:10px 0 0 0' class='glyphicon glyphicon-question-sign pop-right' aria-hidden='true' data-toggle='popover' animation='true' "+
                    "trigger='hover' data-container='body' data-placement='right' title='' data-content='"+helpText + "' data-original-title='"+helpTitle + "'></span>"+
                "</div>"+
                "<div class='col-md-2'>"+
                "<span class='glyphicon glyphicon-remove-circle filterCanceler filterRefiner' aria-hidden='true' onclick='mpgSoftware.variantWF.removeThisFilter(this)' id='remove_"+holderId+"'></span>"+
                "</div>"+
                "</div>");
            if (typeof startingExtent !== 'undefined'){
                $('#'+startHere).val(startingExtent);
            }
            if (typeof endingExtent !== 'undefined'){
                $('#'+endHere).val(endingExtent);
            }
            if (typeof chromosomeName !== 'undefined'){
                $('#'+chromosomeId).val(chromosomeName);
            }

        };

var appendProteinEffectsButtons = function (currentDiv,holderId,sectionName,allFunctionsCheckbox,proteinTruncatingCheckbox,missenseCheckbox,missenseOptions,
                                            polyphenSelect,siftSelect,condelSelect,synonymousCheckbox,noncodingCheckbox,    helpTitle,helpText,valueOne,valueTwo,valueThree,valueFour){
    var allEffectsSelected = '',
    proteinTruncatingSelected = '',
    missenseSelected = '',
    noEffectSynonymousSelected = '',
    noEffectNoncodingSelected = '',
        polyphen1='',polyphen2='',polyphen3='',
        condel1='',condel2='',condel3='',
        sift1='',sift2='',sift3='';
    if (typeof valueOne !== 'undefined'){
        if (valueOne === 'all-effects'){
            allEffectsSelected = "'checked'";
        } else if (valueOne === 'protein-truncating') {
            proteinTruncatingSelected = "'checked'";
        } else if (valueOne === 'missense') {
            missenseSelected = "'checked'";
        } else if (valueOne === 'noEffectSynonymous') {
            noEffectSynonymousSelected = "'checked'";
        } else if (valueOne === 'noEffectNoncoding') {
            noEffectNoncodingSelected = "'checked'";
        }
    }
    if (typeof valueTwo !== 'undefined') {
        if (valueTwo === 'probably_damaging'){
            condel1 = "'checked'";
        } else if (valueTwo === 'possibly_damaging') {
            condel2 = "'checked'";
        } else if (valueTwo === 'benign') {
            condel3 = "'checked'";
        }
    }
    if (typeof valueThree !== 'undefined') {
        if (valueThree === '---'){
            polyphen1 = "'checked'";
        } else if (valueThree === 'deleterious') {
            polyphen2 = "'checked'";
        } else if (valueThree === 'tolerated') {
            polyphen3 = "'checked'";
        }
    }
    if (typeof valueFour !== 'undefined') {
        if (valueFour === '---'){
            sift1 = "'checked'";
        } else if (valueFour === 'deleterious') {
            sift2 = "'checked'";
        } else if (valueFour === 'benign') {
            sift3 = "'checked'";
        }
    }
        currentDiv.append("<div id='"+holderId+"' class='row clearfix'>"+
        "<div class='primarySectionSeparator'>"+
        "<div class='col-sm-offset-1 col-md-3' style='text-align: right'>"+sectionName+"</div>"+
        "<div class='col-md-5'>"+
        "<div class='row clearfix'>"+
        "<div class='col-md-12'>"+
        "<div id='biology-form'>"+
        "<div class='radio'>"+
        "<input type='radio' name='predictedEffects' value='all-effects' id='" +allFunctionsCheckbox + "' onClick=\"chgRadioButton('all-effects')\" "+allEffectsSelected+"/>"+
        "all effects"+
        "</div>"+
        "<div class='radio'>"+
        "<input type='radio' name='predictedEffects' value='protein-truncating' id='" +proteinTruncatingCheckbox + "' onClick=\"chgRadioButton('protein-truncating')\" "+proteinTruncatingSelected+"/>"+
        "protein-truncating"+
        "</div>"+
        "<div class='radio'>"+
        "<input type='radio' name='predictedEffects' value='missense'  id='" +missenseCheckbox + "' onClick=\"chgRadioButton('missense')\" "+missenseSelected+"/>"+
        "missense"+
        "</div>"+
        "<div id='" + missenseOptions+ "' >"+
        "<div class='checkbox'>"+
        "PolyPhen-2 prediction"+
        "<select name='polyphen' id='" +polyphenSelect+ "'>"+
        "<option value=''>---</option>"+
        "<option value='probably_damaging' "+polyphen1+">probably damaging</option>"+
        "<option value='possibly_damaging' "+polyphen2+">possibly damaging</option>"+
        "<option value='benign' "+polyphen2+">benign</option>"+
        "</select>"+
        "</div>"+
        "<div class='checkbox'>"+
        "SIFT prediction"+
        "<select name='sift' id='" +siftSelect+ "'>"+
        "<option value=''>---</option>"+
        "<option value='deleterious' "+sift2+">deleterious</option>"+
        "<option value='tolerated' "+sift3+">tolerated</option>"+
        "</select>"+
        "</div>"+
        "<div class='checkbox'>"+
        "CONDEL prediction"+
        "<select name='condel' id='" +condelSelect+ "'>"+
        "<option value=''>---</option>"+
        "<option value='deleterious' "+condel2+">deleterious</option>"+
        "<option value='benign' "+condel3+">benign</option>"+
        "</select>"+
        "</div>"+
        "</div>"+
        "<div class='radio'>"+
        "<input type='radio' name='predictedEffects' value='noEffectSynonymous'  id='" +synonymousCheckbox + "' onClick=\"chgRadioButton('noEffectSynonymous')\"  "+noEffectSynonymousSelected+"/>"+
        "no effect (synonymous coding)"+
        "</div>"+
        "<div class='radio'>"+
        "<input type='radio' name='predictedEffects' value='noEffectNoncoding'  id='" +noncodingCheckbox + " onClick=\"chgRadioButton('noEffectNoncoding')\"  "+noEffectNoncodingSelected+"/>"+
        "no effect (non-coding)"+
        "</div>"+
        "</div>"+
        "</div>"+
        "</div>"+
        "</div>"+
        "</div>"+
        "<div class='col-md-1'>"+
        "<span style='padding:10px 0 0 0' class='glyphicon glyphicon-question-sign pop-right' aria-hidden='true' data-toggle='popover' animation='true' "+
        "trigger='hover' data-container='body' data-placement='right' title='' data-content='"+helpText + "' data-original-title='"+helpTitle + "'></span>"+
        "</div>"+
        "<div class='col-md-2'>"+
        "<span class='glyphicon glyphicon-remove-circle filterCanceler filterRefiner' aria-hidden='true' onclick='mpgSoftware.variantWF.removeThisFilter(this)' id='remove_"+holderId+"'></span>"+
        "</div>"+
        "</div>");
    $('#all_functions_checkbox').click()

}




        var displayPVChooser = function (holder,equivalence,defaultValue){
            appendValueWithEquivalenceChooser (holder,'pvHolder','p value','pvEquivalence','pvValue',
                'P value help title','everything there is to say about P values',equivalence,defaultValue);
        };
        var displayORChooser = function (holder,equivalence,defaultValue){
            appendValueWithEquivalenceChooser (holder,'pvHolder','odds ratio','orEquivalence','orValue',
                'Odds ratio help title','everything there is to say about an odds ratio',equivalence,defaultValue);
        };
        var displayESChooser = function (holder,equivalence,defaultValue){
            appendValueWithEquivalenceChooser (holder,'esHolder','beta','esEquivalence','esValue',
                'Effect size help title','everything there is to say about an effect sizes',equivalence,defaultValue);
        };
        var displayGeneChooser = function (holder,geneName){
            appendGeneChooser(holder,'geneHolder','gene','region_gene_input',
                'Gene chooser help title','everything there is to say about choosing a gene',geneName);
        };
        var displayPosChooser = function (holder,valueOne,valueTwo,valueThree){
            appendPositionChooser(holder,'geneHolder','position','region_chrom_input','region_start_input','region_stop_input',
                'position specification help title','everything there is to say about an specifying a position',valueOne,valueTwo,valueThree);
        };
        var displayPEChooser = function (holder,valueOne,valueTwo,valueThree,valueFour){
            appendProteinEffectsButtons (holder,'peHolder','proteinEffect','all_functions_checkbox','protein_truncating_checkbox','missense_checkbox',
                'missense-options','polyphenSelect','siftSelect','condelSelect','synonymous_checkbox','noncoding_checkbox',
                'protein effect help title','everything there is to say about a protein effect',valueOne,valueTwo,valueThree,valueFour);
        };
        var displayDSChooser = function (){
            $('#dataSetChooser').show ();
        };
        var displayDataSetChooser = function (initialValue){
            var phenotypeComboBox = UTILS.extractValsFromCombobox(['phenotype']);
            mpgSoftware.variantWF.retrieveDataSets(phenotypeComboBox['phenotype']);
            $('#dataSetChooser').show ();
        };



        /***
         * public
         */
        var respondToPhenotypeSelection = function (){
            var phenotypeComboBox = UTILS.extractValsFromCombobox(['phenotype']);
            mpgSoftware.variantWF.retrieveDataSets(phenotypeComboBox['phenotype']);
            $('#dataSetChooser').show ();
            $('#filterInstructions').text('Choose a sample set  (or click GO for all sample sets):');
            mpgSoftware.variantWF.currentInteractivityState(0);  // but the other widgets know that the user is working on a single filter
            mpgSoftware.variantWF.whatToDoNext(1);
        };

        var respondToDataSetSelection = function (){
            var dataSetComboBox = UTILS.extractValsFromCombobox(['dataSet']);
            var phenotypeComboBox = UTILS.extractValsFromCombobox(['phenotype']);
            mpgSoftware.variantWF.retrievePropertiesPerDataSet(phenotypeComboBox['phenotype'],dataSetComboBox['dataSet']);
            $('#additionalFilterSelection').show ();
            $('#filterInstructions').text('Add filters, if any:');
            mpgSoftware.variantWF.currentInteractivityState(0);
            mpgSoftware.variantWF.whatToDoNext(2);
        };


        var forceRequestForMoreFilters = function (selection,holder,valueOne,valueTwo,valueThree,valueFour){
            switch (selection){
                case 'pvalue':displayPVChooser(holder,valueOne,valueTwo);
                    break;
                case 'oddsratio':displayORChooser(holder,valueOne,valueTwo);
                    break;
                case 'effectsize':displayESChooser(holder,valueOne,valueTwo);
                    break;
                case 'gene':displayGeneChooser(holder,valueOne);
                    break;
                case 'position':displayPosChooser(holder,valueOne,valueTwo,valueThree);
                    break;
                case 'predictedeffect':displayPEChooser(holder,valueOne,valueTwo,valueThree,valueFour);
                    break;
                case 'dataset':displayDSChooser();
                    break;

            }
        };
        var respondToReviseFilters = function (selection,valueOne,valueTwo,valueThree,valueFour){
            var holder = $('#filterHolder');
            var choice = $("#additionalFilters option:selected");
            forceRequestForMoreFilters (selection, holder,valueOne,valueTwo,valueThree,valueFour);
        };

        var respondToRequestForMoreFilters = function (){
            var holder = $('#filterHolder');
            var choice = $("#additionalFilters option:selected");
            var selection = choice.val();
            forceRequestForMoreFilters (selection, holder);
        };
        var requestToAddFilters = function (){
            console.log('hello');
            var holder = $('#filterHolder');
            var choice = $("#additionalFilters option:selected");
            var selection = choice.val();
            forceRequestForMoreFilters (selection, holder);
        };
        return {
            respondToPhenotypeSelection:respondToPhenotypeSelection,
            respondToDataSetSelection:respondToDataSetSelection,
            respondToRequestForMoreFilters:respondToRequestForMoreFilters,
            displayDataSetChooser:displayDataSetChooser,
            respondToReviseFilters:respondToReviseFilters,
            requestToAddFilters:requestToAddFilters
        }

    }());


})();




