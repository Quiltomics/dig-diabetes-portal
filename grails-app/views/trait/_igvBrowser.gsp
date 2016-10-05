
%{--Why I am forced to include style directives explicitly in this page and no other I do not know. There must be--}%
%{--something funny about IGV's use of CSS that is different than everything else in the application.  //TODO -- fix this--}%
<g:set var="restServer" bean="restServerService"/>
<script>
        function  igvSearch(searchString) {
                igv.browser.search(searchString);
                return true;
            }
</script>

<div id="myDiv">
<p>

<g:if test="${g.portalTypeString()?.equals('t2d')}">
    <g:message code="gene.igv.intro1" default="Use the browser"/>
    <g:renderT2dGenesSection>
        <g:message code="gene.igv.intro2" default="(non-Sigma databases)"/>
    </g:renderT2dGenesSection>
       <g:message code="gene.igv.intro3" default="or the traits"/>
    <g:renderT2dGenesSection>
       <g:message code="gene.igv.intro4" default="(GWAS)"/>
    </g:renderT2dGenesSection>
</g:if>
<g:else>
    <g:message code="gene.stroke.igv.intro1" default="Use the browser"/>
</g:else>

</p>

<br/>
<script>
</script>
<nav class="navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1"><span class="sr-only"><g:message code="controls.shared.igv.toggle_nav" /></span><span
                        class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                <a class="navbar-brand">IGV</a></div>
            <div id="bs-example-navbar-collapse-1" class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <li class="dropdown" id="tracks-menu-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><g:message code="controls.shared.igv.tracks" /><b class="caret"></b></a>
                        <ul id="mytrackList" class="dropdown-menu">
<g:if test="${g.portalTypeString()?.equals('t2d')}">

                    %{--<li>--}%
                        %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                            %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                %{--trait: 'T2D',--}%
                                %{--dataset: 'ExSeq_17k_mdv2',--}%
                                %{--pvalue: 'P_EMMAX_FE_IV_17k',--}%
                                %{--name: 'T2D (exome sequencing)',--}%
                                %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                            %{--})">T2D (<g:message code="variant.variantAssociations.source.exomeSequenceQ.help.header" />)</a>--}%
                        %{--</li>--}%
                        %{--<li>--}%
                            %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                %{--trait: 'T2D',--}%
                                %{--dataset: 'ExChip_82k_mdv2',--}%
                                %{--pvalue: 'P_VALUE',--}%
                                %{--name: 'T2D (exome chip)',--}%
                                %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                            %{--})">T2D (<g:message code="variant.variantAssociations.source.exomeChipQ.help.header" />)</a>--}%
                        %{--</li>--}%
                        %{--<li>--}%
                            %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                %{--trait: 'FG',--}%
                                %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                %{--pvalue: 'P_VALUE',--}%
                                %{--name: 'fasting glucose',--}%
                                %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                            %{--})"><g:message code="informational.shared.traits.fasting_glucose" /></a>--}%
                        %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: '2hrG',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: '2-hour glucose',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.two_hour_glucose" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: '2hrI',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: '2-hour insulin',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.two_hour_insulin" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'FI',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'fasting insulin',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.fasting_insulin" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'PI',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'fasting proinsulin',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.fasting_proinsulin" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'HBA1C',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'HBA1C',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.HbA1c" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'HOMAIR',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'HOMA-IR',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.HOMA-IR" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'HOMAB',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'HOMA-B',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.HOMA-B" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'BMI',--}%
                                    %{--dataset: 'GWAS_GIANT_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'BMI',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.BMI" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'WHR',--}%
                                    %{--dataset: 'GWAS_GIANT_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'waist-hip ratio',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.waist_hip_ratio" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'HEIGHT',--}%
                                    %{--dataset: 'GWAS_GIANT_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'height',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.height" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'HDL',--}%
                                    %{--dataset: 'GWAS_GLGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'HDL',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.HDL_cholesterol" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'LDL',--}%
                                    %{--dataset: 'GWAS_GLGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'LDL',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.LDL_cholesterol" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'TG',--}%
                                    %{--dataset: 'GWAS_GLGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'triglycerides',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.triglycerides" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'CAD',--}%
                                    %{--dataset: 'GWAS_CARDIoGRAM_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'coronary artery disease',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.coronary_artery_disease" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'CKD',--}%
                                    %{--dataset: 'GWAS_CKDGenConsortium_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'coronary kidney disease',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.chronic_kidney_disease" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'eGFRcrea',--}%
                                    %{--dataset: 'GWAS_CKDGenConsortium_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'eGFR-creat (serum creatinine)',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.eGFR-creat" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'eGFRcys',--}%
                                    %{--dataset: 'GWAS_CKDGenConsortium_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'eGFR-creat (serum creatinine)',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.eGFR-cys" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'MA',--}%
                                    %{--dataset: 'GWAS_MAGIC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'microalbuminuria',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.microalbuminuria" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'UACR',--}%
                                    %{--dataset: 'GWAS_CKDGenConsortium_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'urinary albumin-to-creatinine ratio',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.urinary_atc_ratio" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'SCZ',--}%
                                    %{--dataset: 'GWAS_PGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'schizophrenia',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.schizophrenia" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'MDD',--}%
                                    %{--dataset: 'GWAS_PGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'major depressive disorder',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.depression" /></a>--}%
                            %{--</li>--}%
                            %{--<li>--}%
                                %{--<a onclick="igv.browser.loadTrack({ type: 'gwas',--}%
                                    %{--url: '${createLink(controller:'trait', action:'getData')}',--}%
                                    %{--trait: 'BIP',--}%
                                    %{--dataset: 'GWAS_PGC_mdv2',--}%
                                    %{--pvalue: 'P_VALUE',--}%
                                    %{--name: 'bipolar disorder',--}%
                                    %{--variantURL: 'http://www.type2diabetesgenetics.org/variantInfo/variantInfo/',--}%
                                    %{--traitURL: 'http://www.type2diabetesgenetics.org/trait/traitInfo/'--}%
                                %{--})"><g:message code="informational.shared.traits.bipolar" /></a>--}%
                            %{--</li>--}%
</g:if>
<g:if test="${g.portalTypeString()?.equals('stroke')}">
    <g:render template="/trait/igvBrowserLinksStroke"/>
</g:if>
                        </ul>
                    </li>
                </ul>
                <div class="nav navbar-nav navbar-left">
                    <div class="well-sm">
                        <input id="goBoxInput" class="form-control" placeholder="Locus Search" type="text"
                               onchange="igvSearch($('#goBoxInput')[0].value)">
                    </div>
                </div>
                <div class="nav navbar-nav navbar-left">
                    <div class="well-sm">
                        <button id="goBox" class="btn btn-default" onclick="igvSearch($('#goBoxInput')[0].value)">
                            <g:message code="controls.shared.igv.search" />
                        </button>
                    </div>
                </div>
                <div class="nav navbar-nav navbar-right">
                    <div class="well-sm">
                        <div class="btn-group-sm"></div>
                        <button id="zoomOut" type="button" class="btn btn-default btn-sm"
                                onclick="igv.browser.zoomOut()">
                            <span class="glyphicon glyphicon-minus"></span></button>
                        <button id="zoomIn" type="button" class="btn btn-default btn-sm" onclick="igv.browser.zoomIn()">
                            <span class="glyphicon glyphicon-plus"></span></button>
                    </div>
                </div>
            </div>
        </div>
    </nav>

</div>
<script id="phenotypeDropdownTemplate"  type="x-tmpl-mustache">
                    {{ #dataSources }}
                        <li>
                        <a onclick="igv.browser.loadTrack({ type: '{{type}}',
                            url: '{{url}}',
                                trait: '{{trait}}',
                                dataset: '{{dataset}}',
                                pvalue: '{{pvalue}}',
                                name: '{{name}}',
                                variantURL: '{{variantURL}}',
                                traitURL: '{{traitURL}}'
                            })">{{name}}</a>
                        </li>
                    {{ /dataSources }}
                    {{ ^dataSources }}
                    <li>No phenotypes available</li>
                    {{ /dataSources }}
</script>

<script type="text/javascript">
    var t2dDataSources = [
        {   type:'gwas',
            trait: 'T2D',
            dataset:'ExSeq_17k_mdv2',
            pvalue: 'P_EMMAX_FE_IV_17k',
            name: 'T2D (exome sequencing)' },
        {   type:'gwas',
            trait: 'T2D',
            dataset:'ExChip_82k_mdv2',
            pvalue: 'P_VALUE',
            name: 'T2D (exome chip)' },
        {   type:'gwas',
            trait: 'FG',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'fasting glucose' },
        {   type:'gwas',
            trait: '2hrG',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: '2-hour glucose' },
        {   type:'gwas',
            trait: '2hrI',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: '2-hour insulin' },
        {   type:'gwas',
            trait: 'FI',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'fasting insulin' },
        {   type:'gwas',
            trait: 'PI',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'fasting proinsulin' },
        {   type:'gwas',
            trait: 'HBA1C',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'HbA1c' },
        {   type:'gwas',
            trait: 'HOMAIR',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'HOMA-IR' },
        {   type:'gwas',
            trait: 'HOMAB',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'HOMA-B' },
        {   type:'gwas',
            trait: 'BMI',
            dataset:'GWAS_GIANT_mdv2',
            pvalue: 'P_VALUE',
            name: 'BMI' },
        {   type:'gwas',
            trait: 'WHR',
            dataset:'GWAS_GIANT_mdv2',
            pvalue: 'P_VALUE',
            name: 'waist-hip ratio' },
        {   type:'gwas',
            trait: 'HEIGHT',
            dataset:'GWAS_GIANT_mdv2',
            pvalue: 'P_VALUE',
            name: 'height' },
        {   type:'gwas',
            trait: 'HDL',
            dataset:'GWAS_GLGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'HDL' },
        {   type:'gwas',
            trait: 'LDL',
            dataset:'GWAS_GLGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'LDL' },
        {   type:'gwas',
            trait: 'TG',
            dataset:'GWAS_GLGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'triglycerides' },
        {   type:'gwas',
            trait: 'CAD',
            dataset:'GWAS_CARDIoGRAM_mdv2',
            pvalue: 'P_VALUE',
            name: 'coronary artery disease' },
        {   type:'gwas',
            trait: 'T2D',
            dataset:'GWAS_CKDGenConsortium_mdv2',
            pvalue: 'P_VALUE',
            name: 'chronic kidney disease' },
        {   type:'gwas',
            trait: 'eGFRcrea',
            dataset:'GWAS_CKDGenConsortium_mdv2',
            pvalue: 'P_VALUE',
            name: 'eGFR-creat (serum creatinine)' },
        {   type:'gwas',
            trait: 'eGFRcys',
            dataset:'GWAS_CKDGenConsortium_mdv2',
            pvalue: 'P_VALUE',
            name: 'eGFR-creat (serum creatinine)' },
        {   type:'gwas',
            trait: 'MA',
            dataset:'GWAS_MAGIC_mdv2',
            pvalue: 'P_VALUE',
            name: 'microalbuminuria' },
        {   type:'gwas',
            trait: 'UACR',
            dataset:'GWAS_CKDGenConsortium_mdv2',
            pvalue: 'P_VALUE',
            name: 'urinary albumin-to-creatinine ratio' },
        {   type:'gwas',
            trait: 'SCZ',
            dataset:'GWAS_PGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'schizophrenia' },
        {   type:'gwas',
            trait: 'MDD',
            dataset:'GWAS_PGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'major depressive disorder' },
        {   type:'gwas',
            trait: 'BIP',
            dataset:'GWAS_PGC_mdv2',
            pvalue: 'P_VALUE',
            name: 'bipolar disorder' }
    ];
    var renderData = {
        dataSources: t2dDataSources,
        url: '${createLink(controller:'trait', action:'getData', absolute:'true')}',
        variantURL: '${createLink(controller:'variantInfo', action:'variantInfo', absolute:'true')}',
        traitURL: '${createLink(controller:'trait', action:'traitInfo', absolute:'true')}'
    };

   var setUpIgv = function (locusName, serverName){
       var igvInitialization = function (dynamicTracks,renderData){
           var options;
           var additionalTracks = [
               {
                   url: "http://data.broadinstitute.org/igvdata/t2d/recomb_decode.bedgraph",
                   min: 0,
                   max: 7,
                   name: "<g:message code='controls.shared.igv.tracks.recomb_rate' />",
                   order: 9998
               },
               {
                   type: "sequence",
                   order: -9999
               },
               {
                   url: "//dn7ywbm9isq8j.cloudfront.net/annotations/hg19/genes/gencode.v18.collapsed.bed",
                   name: "<g:message code='controls.shared.igv.tracks.genes' />",
                   order: 10000
               }
           ];
           options = {
               showKaryo: true,
               showRuler: true,
               showCommandBar: false,
               fastaURL: "//dn7ywbm9isq8j.cloudfront.net/genomes/seq/hg19/hg19.fasta",
               cytobandURL: "//dn7ywbm9isq8j.cloudfront.net/genomes/seq/hg19/cytoBand.txt",
               locus: locusName,
               flanking: 100000,
               tracks: []
           };
           _.forEach(dynamicTracks,function(o){
               var newTrack = o;
               newTrack.url = renderData.url;
               newTrack.variantURL = renderData.variantURL;
               newTrack.traitURL = renderData.traitURL;
               options.tracks.push(newTrack);
           });
           options.tracks = dynamicTracks;
           _.forEach(additionalTracks,function(o){
               options.tracks.push(o);
           });
           return options;
       };



       var promise =  $.ajax({
           cache: false,
           type: "post",
           url: "${createLink(controller: 'trait', action: 'retrievePotentialIgvTracks')}",
           data: {typeOfTracks: 'T2D'           },
           async: true
       });
       promise.done(
               function (data) {
                   var div,
                           options,
                           browser;
                   var renderData = {
                       dataSources: data.allSources,
                       url: '${createLink(controller:'trait', action:'getData', absolute:'true')}',
                       variantURL: '${createLink(controller:'variantInfo', action:'variantInfo', absolute:'true')}',
                       traitURL: '${createLink(controller:'trait', action:'traitInfo', absolute:'true')}'
                   };
                   $("#mytrackList").empty().append(Mustache.render( $('#phenotypeDropdownTemplate')[0].innerHTML,renderData));
                   options = igvInitialization(data.defaultTracks,renderData);
                   div = $("#myDiv")[0];
                   browser = igv.createBrowser(div, options);
               }
       );

        %{--var div,--}%
                %{--options,--}%
                %{--browser;--}%

        %{--div = $("#myDiv")[0];--}%
        %{--options = {--}%
            %{--showKaryo: true,--}%
            %{--showRuler: true,--}%
            %{--showCommandBar: false,--}%
            %{--fastaURL: "//dn7ywbm9isq8j.cloudfront.net/genomes/seq/hg19/hg19.fasta",--}%
            %{--cytobandURL: "//dn7ywbm9isq8j.cloudfront.net/genomes/seq/hg19/cytoBand.txt",--}%
            %{--locus: locusName,--}%
            %{--flanking: 100000,--}%
            %{--tracks: [--}%
%{--<g:if test="${g.portalTypeString()?.equals('stroke')}">--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "Stroke_all",--}%
                    %{--dataset: "GWAS_Stroke_mdv5",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='metadata.Stroke_all' />",--}%
                    %{--variantURL: '${g.createLink(absolute:true, uri:'/variantInfo/variantInfo/')}',--}%
                    %{--traitURL: '${g.createLink(absolute:true, uri:'/trait/traitInfo/')}'--}%
                %{--},--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "Stroke_deep",--}%
                    %{--dataset: "GWAS_Stroke_mdv5",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='metadata.Stroke_deep' />",--}%
                    %{--variantURL: '${g.createLink(absolute:true, uri:'/variantInfo/variantInfo/')}',--}%
                    %{--traitURL: '${g.createLink(absolute:true, uri:'/trait/traitInfo/')}'--}%
                %{--},--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "Stroke_lobar",--}%
                    %{--dataset: "GWAS_Stroke_mdv5",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='metadata.Stroke_lobar' />",--}%
                    %{--variantURL: '${g.createLink(absolute:true, uri:'/variantInfo/variantInfo/')}',--}%
                    %{--traitURL: '${g.createLink(absolute:true, uri:'/trait/traitInfo/')}'--}%
                %{--},--}%
%{--</g:if>--}%
%{--<g:else>--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${restServer.currentRestServer()}getData",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "T2D",--}%
                    %{--dataset: "GWAS_DIAGRAM_mdv2",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='portal.header.title.short' />",--}%
                    %{--variantURL: "http://www.type2diabetesgenetics.org/variantInfo/variantInfo/",--}%
                    %{--traitURL: "http://www.type2diabetesgenetics.org/trait/traitInfo/"--}%
                %{--},--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "FG",--}%
                    %{--dataset: "GWAS_MAGIC_mdv2",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='informational.shared.traits.fasting_glucose' />",--}%
                    %{--variantURL: "http://www.type2diabetesgenetics.org/variantInfo/variantInfo/",--}%
                    %{--traitURL: "http://www.type2diabetesgenetics.org/trait/traitInfo/"--}%
                %{--},--}%
                %{--{--}%
                    %{--type: "gwas",--}%
                    %{--url: "${createLink(controller:'trait', action:'getData')}",--}%
                    %{--trait: "FI",--}%
                    %{--dataset: "GWAS_MAGIC_mdv2",--}%
                    %{--pvalue: "P_VALUE",--}%
                    %{--name: "<g:message code='informational.shared.traits.fasting_insulin' />",--}%
                    %{--variantURL: "http://www.type2diabetesgenetics.org/variantInfo/variantInfo/",--}%
                    %{--traitURL: "http://www.type2diabetesgenetics.org/trait/traitInfo/"--}%
                %{--},--}%
%{--</g:else>--}%
                %{--{--}%
                    %{--url: "http://data.broadinstitute.org/igvdata/t2d/recomb_decode.bedgraph",--}%
                    %{--min: 0,--}%
                    %{--max: 7,--}%
                    %{--name: "<g:message code='controls.shared.igv.tracks.recomb_rate' />",--}%
                    %{--order: 9998--}%
                %{--},--}%
                %{--{--}%
                    %{--type: "sequence",--}%
                    %{--order: -9999--}%
                %{--},--}%
                %{--{--}%
                    %{--url: "//dn7ywbm9isq8j.cloudfront.net/annotations/hg19/genes/gencode.v18.collapsed.bed",--}%
                    %{--name: "<g:message code='controls.shared.igv.tracks.genes' />",--}%
                    %{--order: 10000--}%
                %{--}--}%
            %{--]--}%
        %{--};--}%

        %{--browser = igv.createBrowser(div, options);--}%
    };

</script>

