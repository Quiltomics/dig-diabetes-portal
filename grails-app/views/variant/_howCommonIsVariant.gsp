
<a name="populations"></a>
<h2><strong>How common is <%=variantToSearch%>?</strong></h2>

<p>
    Variants are defined as common (found in 5 percent of the population or more), low-frequency (.5 percent to 5 percent), rare (below .5 percent), or private (seen in only one individual or family).
</p>

<g:if test="${show_exseq}">
    <p>In exome sequencing data available on this portal, the minor allele frequency of <%=variantToSearch%> is:</p>
    <ul>
        <span id="howCommonInExomeSequencing"></span>

    </ul>



%{--todo: (from Brett) tab over the following two sections (and bold them) to indicate that they are part of exome chip#}--}%
<p>Heterozygous carriers</p>
<ul>
<span id="howCommonInHeterozygousCarriers"></span>
</ul>

    <p>Homozygous carriers</p>
    <ul>
<span id="howCommonInHomozygousCarriers"></span>
    </ul>
</g:if>
<g:else>
    <p>This variant is not in exome sequencing data available on this portal.</p>
</g:else>

<g:if test="${show_exchp}">

    <span id="eurocentricVariantCharacterization"></span>

</g:if>

<g:if test="${show_sigma}">


    <span id="sigmaVariantCharacterization"></span>

</g:if>

<div class="separator"></div>


