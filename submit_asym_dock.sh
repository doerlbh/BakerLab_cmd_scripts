for i in *asymdock;do
cd $i
echo submitting...
/work/robetta/workspace/labFragPicker_DO_NOT_REMOVE/bakerlab_scripts/boinc/submit_to_boinc.py run.docking.boinc
cd ../
done
