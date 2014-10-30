<%@ page import="dport.Phenotype" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="core"/>
    <r:require modules="core"/>
    <r:layoutResources/>

</head>
<body>
 <script>
     $(function() {

         $('#gene-input').typeahead(
                  {
                     source: function(query, process) {
                         $.get('../gene', {query: query}, function(data) {
                             process(data);
                         })
                     }
                 }
         );

         $('#gene-go').on('click', function() {
             var gene_symbol = $('#gene-input').val();
             if (gene_symbol) {
                 window.location.href = "${createLink(controller:'gene',action:'geneInfo')}/" + gene_symbol;
             }
         });

         $('#variant-go').on('click', function() {
             var variant_id = $('#variant-input').val();
             if (variant_id) {
                 window.location.href = "${createLink(controller:'variant',action:'variantInfo')}/" + variant_id;
             }
         });

         $('#region-go').on('click', function() {
             var region_str = $('#region-input').val();
             if (region_str)   {
                 window.location.href = "${createLink(controller:'region',action:'regionInfo')}/" + region_str;
             }
         });

         $('#trait-go').on('click', function() {
             var trait_val = $('#trait-input option:selected').val();
             var significance = 0;
             if ($('#id_significance_genomewide').prop('checked')) {
                 significance = 5e-8;
             } else {
                 significance = $('#custom_significance_input').val();
             }
             if (trait_val == "" || significance == 0) {
                 alert('Please choose a trait and enter a valid significance!')
             } else {
                 window.location.href = "${createLink(controller:'trait',action:'traitSearch')}"+"?trait=" + trait_val +"&significance=" + significance;
             }
         });

     });
 </script>
<div id="main">
    <div class="container">
<g:renderExomeSequenceSection>
    <p>
        This portal contains results from genetic association studies of type 2 diabetes.
        Datatsets include exome sequencing results contributed by <a class="boldlink" href="${createLink(controller:'informational', action:'t2dgenes')}">T2D-GENES</a>
        and <a class="boldlink" href="${createLink(controller:'informational', action:'got2d')}">GoT2D</a> (n&asymp;12,940);
    exome chip results contributed by <a class="boldlink" href="${createLink(controller:'informational', action:'got2d')}">GoT2D</a> (n&asymp;79,854);
    and GWAS results contributed by <a class="boldlink" href="http://diagram-consortium.org/about.html">DIAGRAM</a> (n&asymp;69,033).
    The portal also contains  results from large GWAS meta-analyses of <a class="boldlink" href="${createLink(controller:'informational', action:'hgat')}">24 other traits</a>.
    </p>

</g:renderExomeSequenceSection>


        <p>
            <g:message code="mainpage.to.query.these.data"/>
        </p>

        <div class="row">
            <div class="col-sm-5">
                <div class="main-searchbox">
                    <h2><g:message code="mainpage.start.with.gene"/></h2>
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" id="gene-input">
                        <span class="input-group-btn">
                            <button id="gene-go" class="btn btn-primary btn-lg" type="button">Go!</button>
                        </span>
                    </div>
                    <div class="helptext">enter <a class="boldlink" href="http://www.genenames.org" target="_blank">HGNC</a> gene symbol</div>
                </div>
                <div class="main-searchbox">
                    <h2><g:message code="mainpage.start.with.variant"/></h2>
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" id="variant-input">
                        <span class="input-group-btn">
                            <button id="variant-go" class="btn btn-primary btn-lg" type="button">Go!</button>
                        </span>
                    </div>
                    <div class="helptext">enter rsID (e.g., rs13266634)</div>
                </div>
                <div class="main-searchbox">
                    <h2><g:message code="mainpage.start.with.region"/></h2>
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" id="region-input">
                        <span class="input-group-btn">
                            <button id="region-go" class="btn btn-primary btn-lg" type="button">Go!</button>
                        </span>
                    </div>
                    <div class="helptext">enter coordinates (e.g., chr9:21,940,000-22,190,000)</div>
                </div>
            </div>

            <div class="col-sm-5 col-sm-offset-1">
                <div class="row">
                    <div class="col-sm-9">
                        <h2>
                            <g:message code="mainpage.search.variant"/><br/>
                            <small>(from exome and exome chip data)</small>
                        </h2>
                    </div>
                    <div class="col-sm-3" style="padding-top: 40px; text-align: right;">
                        <a href="${createLink(controller:'variantSearch', action:'variantSearch')}" class="btn btn-primary btn-lg">Go!</a>
                    </div>
                </div>
                <h2>
                    <g:message code="mainpage.search.variant.related.traits"/><br/>
                    <small>(from large GWAS meta-analyses)</small>
                </h2>
                <div class="input-group input-group-lg">
                    <select name="" id="trait-input" class="form-control" style="width:95%;">
                        <option value="">-- Select A Trait --</option>
                        <optgroup label="Cardiometabolic">
                            <g:each in="${Phenotype.list()}" var="phenotype">
                                <g:if test="${phenotype.category=='cardiometabolic'}" >
                                    <option value=${phenotype.databaseKey}>${phenotype.name}</option>
                                </g:if>
                            </g:each>
                        </optgroup>
                        <optgroup label="Other">
                            <g:each in="${Phenotype.list()}" var="phenotype">
                                <g:if test="${phenotype.category=='other'}" >
                                    <option value="${phenotype.databaseKey}">${phenotype.name}</option>
                                </g:if>
                            </g:each>
                        </optgroup>
                    </select>
                </div>
                <h4><g:message code="mainpage.set.association.threshold"/></h4>
                <div class="row">
                    <g:form name="trait" action="traitSearch">
                    <div class="col-sm-9">
                        <div class="radio">
                            <label>
                                <input id="id_significance_genomewide" type="radio" name="significance" value="genomewide" checked />
                                genome-wide significance  |  &le; 5 x 10<sup>-8</sup>
                            </label>
                        </div>
                        <div class="radio">
                            <label for="id_significance_custom">
                                <input id="id_significance_custom" type="radio" name="significance" value="custom" />
                                custom
                            </label>
                            <input type="text" id="custom_significance_input"/>
                            or stronger
                        </div>
                    </div>
                    <div class="col-sm-3" style="padding-top: 10px; text-align: right;">
                        <span class="input-group-btn">
                            <button id="trait-go" class="btn btn-primary btn-lg" type="button">Go!</button>
                        </span>
                    </div>
                    </g:form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>
