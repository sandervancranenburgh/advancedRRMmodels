<h1 class="font_2 wixui-rich-text__text" style="text-align: center;">Decision rule robust experimental designs</h1>
<p class="font_8 wixui-rich-text__text">Despite compelling evidence that decision-makers use a wide range of decision rules when making choices, the design of Stated Choice experiments&nbsp;has exclusively been based on the (often implicit) assumption that decision-makers make choices using (linear-additive) Random Utility Maximization (RUM) rules. In a recent&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/blob/main/RRM%20Methodology/Decision%20rule%20robust%20designs/Cranenburgh%20et%20al_TrA_2017.pdf" target="_blank" rel="noopener">study</a></span>&nbsp;I show that efficient experimental designs can also be created for RRM.&nbsp;One particularly important result of this study is that designs that are efficient for estimating RUM models can be highly inefficient for estimating RRM models, and vice versa. Therefore, it is appealing to&nbsp;take&nbsp;multiple decision rules into account when creating efficient experimental designs.</p>
<h2 class="font_5 wixui-rich-text__text">&nbsp;</h2>
<h2 class="font_5 wixui-rich-text__text"><span class="wixui-rich-text__text">Create your own decision rule robust experimental design!</span></h2>
<p class="font_8 wixui-rich-text__text">I&nbsp;have created a software tool&nbsp; -called Robust Design Generator (RDG)-&nbsp;for creating efficient designs optimised for regret minimisation, utility maximisation, or both, see the screen shot below.&nbsp;A&nbsp;recent&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://www.sciencedirect.com/science/article/pii/S1755534518300940" target="_blank" rel="noopener">paper</a></span>&nbsp;by Andrew Collins and me explains&nbsp;how to generate designs using this tool.&nbsp;</p>
<p><img src="https://github.com/sandervancranenburgh/advancedRRMmodels/blob/main/RRM%20Methodology/Decision%20rule%20robust%20designs/DecisionRule.png" alt="" /></p>
<h2 class="font_5 wixui-rich-text__text"><span class="wixui-rich-text__text">Installation</span></h2>
<p class="font_8 wixui-rich-text__text">There are 2 ways to use the Robust Design Generator tool:</p>
<p class="font_8 wixui-rich-text__text">As a MATLAB app, which runs within the MATLAB environment. Advantages of using the Matlab app are that it allows the analyst to extend and build upon the software code and that it is very easy to install. This approach requires the analyst to have installed MATLAB R2017 (or higher).&nbsp;</p>
<ul class="wixui-rich-text__text">
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/blob/main/RRM%20Methodology/Decision%20rule%20robust%20designs/Robust%20Design%20Generator_V1.mlappinstall" target="_blank" rel="noopener">here</a></span>&nbsp;to download the MATLAB app.&nbsp; ​</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">​Open MATLAB</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Browse to the "APPS" tab (top left)</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Select "Install App" and browse to the download location</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Click (once) on the&nbsp;icon, and wait for the app to start​</p>
</li>
</ul>
<p class="font_8 wixui-rich-text__text"><span class="wixGuard wixui-rich-text__text">​</span></p>
<p class="font_8 wixui-rich-text__text">As a stand-alone application (Freeware). This approach does not require a MATLAB license. Therefore, in this form the tool can be used by anybody, without the need to use commercial software. It does require MS Windows and about 2GB hard drive space.</p>
<ul class="wixui-rich-text__text">
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">For&nbsp;<span class="wixui-rich-text__text">WINDOWS</span>&nbsp;click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Methodology/Decision%20rule%20robust%20designs/Windows" target="_blank" rel="noopener">here</a></span>&nbsp;to download the standalone&nbsp;app.&nbsp;</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Unzip the files.&nbsp;&nbsp;</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Double click the MyAppInstaller_web.exe&nbsp;to install the MATLAB environment</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Double click the Robust_Design_Generator.exe. The RDG will start.</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">For&nbsp;<span class="wixui-rich-text__text">MacOS</span>&nbsp;click&nbsp;<span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/tree/main/RRM%20Methodology/Decision%20rule%20robust%20designs/MacOS" target="_blank" rel="noopener">here</a></span>&nbsp;to download the MacOS standalone&nbsp;app.&nbsp;</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Double-click the downloaded file, the installer opens and will guide you through the installation process.</p>
</li>
<li class="wixui-rich-text__text">
<p class="font_8 wixui-rich-text__text">Open Launchpad, then go to "Delft_University_of_Technology" and click in "RobustDesignGenerator". The app will start.</p>
</li>
</ul>
<p class="font_8 wixui-rich-text__text"><span class="wixGuard wixui-rich-text__text">​</span></p>
<p class="font_8 wixui-rich-text__text">FURTHER READING</p>
<p class="font_8 wixui-rich-text__text"><span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://github.com/sandervancranenburgh/advancedRRMmodels/blob/main/RRM%20Methodology/Decision%20rule%20robust%20designs/Cranenburgh%20et%20al_TrA_2017.pdf" target="_blank" rel="noopener">Van Cranenburgh, S., Rose, J.M. &amp; Chorus, C.G.</a></span>&nbsp;&nbsp; &ldquo;On the robustness of efficient experimental designs towards the underlying decision rule&rdquo; Transportation Research Part A: Policy and Practice.&nbsp;</p>
<p class="font_8 wixui-rich-text__text"><span class="wixui-rich-text__text"><a class="wixui-rich-text__text" href="https://www.sciencedirect.com/science/article/pii/S1755534518300940" target="_blank" rel="noopener">Van Cranenburgh, S. &amp; Collins, A.T.</a></span>&nbsp; &nbsp;&ldquo;New software tools for creating efficient stated choice experimental designs robust for regret minimisation and utility maximisation decision rules&rdquo;. Journal of Choice Modelling,&nbsp;(31), pg 104-123.</p>
