##### Making fragments
/work/robetta/workspace/labFragPicker_DO_NOT_REMOVE/bakerlab_scripts/boinc/make_fragments.py -pdbs_folder fold_where_my_pdbs_are -n_proc 20


##### Checking
# the following ones you have to go inside specific folder to do that.

#Check fragment quality
#It will write a .png image file, and also print out the sum of the best RMSDs for the 6 worst fragments; if you look at the sum6 number, it's usually a good indicator (lower is better, my best ones for the sum (not sum6) were between 10-12). The png file should show some decent plots with low rmsd values.
/work/zibochen/scripts/boinc/analyze_fragments.sh >frag_quanlity.txt &

#Check secondary structures (works on momomers only)
#It will give a screen output with the last number being the agreement between design and prediction (the higher the better). As a rule of thumb, at least >0.89 is good. It will also generate a .pdb_dssp.horiz file that shows the agreement between design (Dssp) and prediction (Pred).
/work/grocklin/gabe_scripts/psipred_all.py *.pdb >dssp.txt & #monomers only

#Fold/Symmetric fold and dock/Asymmetric fold and dock
#To test your job before submitting:
~boinc/bin/run_test.pl boinc_submit.txt


##### Submission

#put those folders into one folder (in this case fold_boinc)
mv 60722t1-_-2.85_4.85_0.00_101.14_0.00_-2.85_10.09_90.00_212.00_-2.50_0001_* fold_boinc/
  cd fold_boinc/
  # ls
  # more ~zibochen/scripts/boinc/setup_fold_and_dock.sh
  j=1;for i in */;do cd $i;/work/robetta/workspace/labFragPicker_DO_NOT_REMOVE/bakerlab_scripts/boinc/prepare_fold.py -nj_relax 50 -nj_abinitio 5000 baihanf$j;cd ../;let j=j+1;done
  for i in */;do cd $i;/work/robetta/workspace/labFragPicker_DO_NOT_REMOVE/bakerlab_scripts/boinc/submit_to_boinc.py run.fold.boinc.job;cd ../;done

##### Final testing
~boinc/bin/run_test.pl run.fold.boinc.job

##### Plotting in specific folder
~sboyken/scripts/bakerlab_scripts/boinc/plot_energy_landscape.py -refe