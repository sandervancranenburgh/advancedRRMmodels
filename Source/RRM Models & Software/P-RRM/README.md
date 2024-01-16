<h1 class="font_6 wixui-rich-text__text" style="text-align: center;"><span class="wixui-rich-text__text">The P-RRM model</span></h1>
<div id="bgLayers_comp-la7woksn" class="MW5IWV" data-hook="bgLayers">&nbsp;</div>
<div class="" data-mesh-id="comp-la7woksninlineContent" data-testid="inline-content">
<div data-mesh-id="comp-la7woksninlineContent-gridContainer" data-testid="mesh-container-content">
<div id="i20dw1f4" class="BaOVQ8 tz5f0K i20dw1f4 wixui-rich-text" data-testid="richTextElement">
<p class="font_8 wixui-rich-text__text" dir="ltr"><span class="wixui-rich-text__text">The P-RRM model postulates the strongest random regret minimization behaviour possible within the RRM modelling framework.&nbsp;</span>It is one of the two special limiting cases of the &micro;RRM model. See&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="http://www.sciencedirect.com/science/article/pii/S0965856415000166" target="_blank" rel="noopener">Cranenburgh et al. 2015</a></span>&nbsp;for an extensive description of the model.</p>
<p class="font_8 wixui-rich-text__text" dir="ltr">The key idea behind this model is that no rejoice (i.e. the opposite of regret) is experienced when the considered alternative outperforms a competitor alternative with regard an attribute&nbsp;<span class="wixui-rich-text__text">m.&nbsp;</span>This, in contrast to the Classical RRM model and the &micro;RRM model which both postulate that regrets&nbsp;<span class="wixui-rich-text__text">and</span>&nbsp;rejoices are experienced. The figure on the right depicts attribute level regret function of the P-RRM model.</p>
<p class="font_8 wixui-rich-text__text" dir="ltr">To estimate a P-RRM model, we need to compute the so-called P-RRM X-vector, denoted x-P-RRM. Because the model is essentially linear this can be done prior to estimation. A prerequisite to do so however is that the signs of the taste parameters are known prior to estimation - which is typically the case. Once we have the P-RRM X-vector, estimation of the P-RRM model is just as simple and fast as estimation of a linear-additive RUM model.</p>
 <p class="font_8 wixui-rich-text__text" dir="ltr"><img src="https://github.com/sandervancranenburgh/advancedRRMmodels/blob/main/RRM%20Models%20%26%20Software/P-RRM/P_RRM.png" alt="" /></p>
<p class="font_8 wixui-rich-text__text" dir="ltr">The linear-additive form of the P-RRM model also makes it very attractive from a computational perspective. As the X-vector can be computed prior to the estimation, runtimes of the P-RRM model are proportional with choice set size, as opposed to quadratic - which is the case for the other RRM models.</p>
<p class="font_8 wixui-rich-text__text">&nbsp;</p>
<h3 class="font_7 wixui-rich-text__text" dir="ltr">MATLAB</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/MATLAB" target="_blank" rel="noopener">here</a></span>&nbsp;for a bundle of MATLAB codes, which includes:</p>
<ul class="font_8 wixui-rich-text__text">
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text" dir="ltr">Code to compute P-RRM X-vectors</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text" dir="ltr">Code to estimate P-RRM-MNL models</p>
</li>
</ul>
<h3 class="font_7 wixui-rich-text__text" dir="ltr">BISON BIOGEME&nbsp;</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/BISON%20BIOGEME" target="_blank" rel="noopener">here</a></span>&nbsp;for BISON BIOGEME P-RRM estimation code to estimate shopping choice data.</p>
<h3 class="font_7 wixui-rich-text__text" dir="ltr">PYTHON BIOGEME</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/PYTHON%20BIOGEME" target="_blank" rel="noopener">here</a></span>&nbsp;for PYTHON BIOGEME P-RRM estimation code to estimate shopping choice data.</p>
<h3 class="font_7 wixui-rich-text__text" dir="ltr">PANDAS BIOGEME</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/PANDAS%20BIOGEME" target="_blank" rel="noopener">here</a></span>&nbsp;for PANDAS BIOGEME P-RRM estimation code to estimate shopping choice data.</p>
<h3 class="font_8 wixui-rich-text__text">Apollo R</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/Apollo%20R" target="_blank" rel="noopener">here</a></span>&nbsp;for Apollo R&nbsp;P-RRM estimation code to estimate shopping choice data.</p>
<h3 class="font_8 wixui-rich-text__text">EXAMPLE DATA FILE</h3>
<p class="font_8 wixui-rich-text__text" dir="ltr">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="[https://surfdrive.surf.nl/files/index.php/s/pyTXgpXx0JPTHhv](https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Models%20%26%20Software/P-RRM/EXAMPLE%20DATA)" target="_blank" rel="noopener">here</a></span>&nbsp;to download the example shopping choice data file&nbsp;(see&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="http://journals.ama.org/doi/abs/10.1509/jmkr.42.1.109.56884" target="_blank" rel="noopener">Arentze et al. 2005</a></span>&nbsp;for more details on the data)</p>
</div>
</div>

