<%@ page import="dport.Phenotype" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="core"/>
    <r:require modules="core"/>
    %{--<r:require modules="portalHome"/>--}%
    <r:layoutResources/>
</head>
<style>
.unpaddedSection {
    padding-left : 0;
    padding-right : 0;
}
</style>
<body>
<script>

    $(function () {
        "use strict";

        /***
         * type ahead recognizing genes
         */
        $('#generalized-input').typeahead({
            source: function (query, process) {
                $.get('<g:createLink controller="gene" action="index"/>', {query: query}, function (data) {
                    process(data);
                })
            }
        });

        /***
         * respond to end-of-search-line button
         */
        $('#generalized-go').on('click', function () {
            var somethingSymbol = $('#generalized-input').val();
            if (somethingSymbol) {
                window.location.href = "${createLink(controller:'gene',action:'findTheRightDataPage')}/" + somethingSymbol;
            }
        });

        /***
         * capture enter key, make it equivalent to clicking on end-of-search-line button
         */
        $("input").keypress(function (e) { // capture enter keypress
            var k = e.keyCode || e.which;
            if (k == 13) {
                $('#generalized-go').click();
            }
        });

        /***
         *  Launch find variants associated with other traits
         */
        $('#traitSearchLaunch').on('click', function () {
            var trait_val = $('#trait-input option:selected').val();
            var significance = 5e-4;
            if (trait_val == "" || significance == 0) {
                alert('Please choose a trait and enter a valid significance!')
            } else {
                window.location.href = "${createLink(controller:'trait',action:'traitSearch')}" + "?trait=" + trait_val + "&significance=" + significance;
            }
        });


    });

</script>

%{--Main search page for application--}%
<div id="main">
    <div class="container">
        <div class="row">
            <div class="col-md-8">

                %{--gene, variant or region--}%
                <div class="row">
                    <div class="col-xs-11 col-md-11 col-lg-11 unpaddedSection">

                        <h2><g:message code="primary.text.input.header"/></h2>

                        <div class="input-group input-group-lg">
                            <input type="text" class="form-control" id="generalized-input"></span>
                            <span class="input-group-btn">
                                %{--<span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>--}%
                                <button id="generalized-go" class="btn btn-primary btn-lg" type="button">
                                    <g:message code="mainpage.button.imperative"/>
                                </button>
                            </span>
                        </div>

                        <g:renderSigmaSection>
                            <div class="helptext"><g:message code="mainpage.start.with.gene.subtext.sigma"/></div>
                        </g:renderSigmaSection>
                        <g:renderNotSigmaSection>
                            <div class="helptext">examples:
                                <a href='<g:createLink controller="gene" action="geneInfo"
                                                       params="[id: 'SLC30A8']"/>'>SLC30A8</a>,
                                <a href='<g:createLink controller="variant" action="variantInfo"
                                                       params="[id: 'rs13266634']"/>'>rs13266634</a>,
                                <a href='<g:createLink controller="region" action="regionInfo"
                                                       params="[id: 'chr9:21,940,000-22,190,000']"/>'>chr9:21,940,000-22,190,000</a>
                            </div>
                        </g:renderNotSigmaSection>

                    </div>

                    <div class="col-xs-1 col-md-1 col-lg-1"></div>
                </div>

                %{--set up search form--}%


                <div class="row sectionBuffer">
                    <div class="col-xs-10 col-md-10 col-lg-10 unpaddedSection">
                        <h2>
                            <g:message code="variant.search.header"/>
                        </h2>
                    </div>

                    <div class="col-xs-1 col-md-1 col-lg-1 unpaddedSection" style="margin-top: 20px; padding: 0">
                        <a href="${createLink(controller: 'variantSearch', action: 'variantSearch')}"
                           class="btn btn-primary btn-lg"><g:message code="mainpage.button.imperative"/></a>
                    </div>

                    <div class="col-xs-1  col-md-1 col-lg-1">

                    </div>

                </div>

                <div class="row">
                    <div class="col-md-12 medText">
                        <g:message code="variant.search.specifics"/>
                    </div>
                </div>

                %{--variants with other traits--}%
                <div class="row sectionBuffer">

                    <div class="col-xs-10 col-md-10 col-lg-10 unpaddedSection">

                        <h2>
                            <g:message code="trait.search.header"/><br/>
                        </h2>

                        %{--<div class="input-group input-group-lg">--}%
                            <select name="" id="trait-input" class="form-control btn-group btn-input clearfix">

                                <optgroup label="Cardiometabolic">
                                    <g:each in="${Phenotype.list()}" var="phenotype">
                                        <g:if test="${phenotype.category == 'cardiometabolic'}">
                                            <option value= ${phenotype.databaseKey}>${phenotype.name}</option>
                                        </g:if>
                                    </g:each>
                                </optgroup>
                                <optgroup label="Other">
                                    <g:each in="${Phenotype.list()}" var="phenotype">
                                        <g:if test="${phenotype.category == 'other'}">
                                            <option value="${phenotype.databaseKey}">${phenotype.name}</option>
                                        </g:if>
                                    </g:each>
                                </optgroup>



                            </select>
                        %{--</div>--}%
                    </div>
                    <div class="col-xs-1 col-md-1  col-lg-1 unpaddedSection"  style="margin-top: 50px; padding: 0">
                        <div id="traitSearchLaunch" class="btn btn-primary btn-lg"><g:message code="mainpage.button.imperative"/></div>
                    </div>
                    <div class="col-xs-1 col-md-1 col-lg-1">

                    </div>

                </div>

            </div>

            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-offset-1 col-md-10 medTextDark">
                        <g:message code="about.the.portal.header"/>
                    </div>

                    <div class="col-md-1"></div>

                </div>

                <div class="row">
                    <div class="col-md-offset-1 col-md-10 medText">
                        <g:message code="about.the.portal.text"/>
                    </div>

                    <div class="col-md-1"></div>
                </div>

            </div>
        </div>

        %{--video--}%
        <div class="row sectionBuffer">
            <div class="col-md-6">
                <a href="${createLink(controller:'home',action:'introVideoHolder')}">
                <div class="medTextDark">Video: How to use the portal</div>
                </a>

            </div>

            <div class="col-md-6">
            </div>

        </div>

    </div>
</div>

</body>
</html>
