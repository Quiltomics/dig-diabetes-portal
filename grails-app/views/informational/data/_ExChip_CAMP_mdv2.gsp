<div class="panel-body">

    <h6 style="color:#ccc;">Data set phenotypes</h6>
    <ul>
        <li>Type 2 diabetes</li>
        <li>Fasting glucose</li>
        <li>Fasting insulin</li>
    </ul>

    <h4>Data Set Subjects</h4>

    <table class="table table-condensed table-responsive table-striped">
        <tr><th>Cases</th><th>Controls</th><th>Cohort</th><th>Ethnicity</th></tr>

        <tr><td>540</td><td>2,913</td><td><a onclick="showSection(event)">Massachusetts General Hospital Cardiology and Metabolic Patient cohort (CAMP MGH)</a>

            <div style="display: none;" class="cohortDetail">
                <table border="1">
                    <tr><th>Case selection criteria</th><th>Control selection criteria</th></tr>
                    <tr>
                        <td valign="top">Healthcare provider diagnosis of type 2 diabetes</td>
                        <td valign="top">No healthcare provider diagnosis of type 2 diabetes</td></tr>
                </table>
            </div></td><td>Mixed</td></tr>
    </table>
    <h6 style="color:#ccc;">Project</h6>
    <h4>CAMP MGH</h4>

    <p>This work was performed at Pfizer Inc. and Massachusetts General Hospital as part of a public-private partnership to generate genotype data for a cardiometabolic and prediabetic cohort.</p>

<h6 style="color:#ccc;">Experiment summary</h6>
<p>The MGH Cardiology and Metabolic Patient (CAMP MGH) cohort comprises 3,857 subjects recruited between 2008 and 2012. Two thirds of the subjects were drawn from patients who had appointments with a physician in the MGH Heart Center, while one third were recruited independent of any hospital visit. All subjects had plasma and serum samples collected, as well as blood for genomic DNA. Subjects with known diabetes had vascular reactivity measurements (FMD of brachial artery), while subjects without known diabetes had an oral glucose tolerance test. Exome Core Chip genotyping was performed on all subjects.</p>

<h6 style="color:#ccc;">Overview of analysis results</h6>
<p>Data were analyzed by the Analysis Team at the Accelerating Medicines Partnership Data Coordinating Center (AMP-DCC), Broad Institute. After removing related samples and samples flagged for non-type 2 diabetes, 3,453 samples (540 type 2 diabetes cases and 2,913 controls) were analyzed. Two different statistical models were applied to analyze associations of variants with type 2 diabetes, fasting glucose levels, and fasting insulin levels.</p>

<p>The strongest signal observed for association with T2D was on chromosome 6 near <i>HLA-C</i>, which is a known T1D-associated locus. Its detection in the CAMP data is not currently explicable, since type 1 diabetics had been removed from the sample set that was analyzed. Further work will be done to investigate the specific samples that are driving this signal. Other than the <i>HLA-C</i> signal, additional signals of nominal significance were detected at previously reported T2D-associated loci.

<p>A variant associated with fasting glucose levels at genome-wide significance was detected near <i>MTNR1B</i> on chromosome 11. Additional signals of nominal significance were detected at loci previously reported to be associated with fasting glucose levels, and several rare variants with significant effects were also seen.</p>

<p>A variant associated with fasting insulin levels at genome-wide significance was detected near CHMP4C on chromosome 8. However, since the minor allele count for this variant was only 8 in this data set, the result could be spurious. A signal of nominal significance was detected at the <i>IGF1</i> locus, previously reported to be associated with fasting insulin levels.</p>

<h6 style="color:#ccc;">Detailed reports</h6>

<p>AMP-DCC Data Analysis Report (<a href="https://s3.amazonaws.com/broad-portal-resources/AMP-DCC_Data_Analysis_Report_CAMP_Phase1_2016_1003.pdf">download PDF</a>)</p>
<p>Genotype Data Quality Control Report (<a href="https://s3.amazonaws.com/broad-portal-resources/AMP_T2DKP_CAMP_QC_Results.pdf">download PDF</a>)</p>

<h6 style="color:#ccc;">Accessing CAMP data in the T2D Knowledge Portal</h6>
<p>CAMP data are available:
<ul>
<li>On Gene Pages in the Variants & Associations table</li>
<li>On Variant Pages in the Associations at a glance section and in the Association statistics across traits table</li>
<li>Via the Variant Finder tool, for the phenotypes T2D, fasting glucose, and fasting insulin</li>
</ul></p>

<h6 style="color:#ccc;">Future plans for CAMP data in the T2D Knowledge Portal</h6>
<p>Associations of variants with T2D, fasting glucose, and fasting insulin from the CAMP data will be made available via two additional analysis tools in the Portal:</p>
<ul>
<li>LocusZoom, an interactive visualization of variants and associations that is displayed on both Gene Pages and Variant Pages</li>
<li>Genetic Association Interactive Tool (GAIT), which enables custom association analysis for either single variants (available on Variant Pages) or for the set of variants in and near a gene (Interactive burden test, available on Gene Pages)</li>
</ul></p>

<p>CAMP data will be analyzed for associations of variants with additional phenotypes, and these results will be made available in the Portal via the pages and tools listed above.</p>

</div>
