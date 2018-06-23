PATH_EXPORT_VENVWRAPPER_SH="/vagrant/setup_sessionconfig/export_venvwrapper_vars.sh"
PATH_EXPORT_PROJECT_NAME="/vagrant/setup_sessionconfig/export_project_name.sh"
source $PATH_EXPORT_VENVWRAPPER_SH
source $PATH_EXPORT_PROJECT_NAME

PATH_VAGRANT_USR_BASHRC="/home/vagrant/.bashrc"

echo "Making venv in $WORKON_HOME/$PROJECT_NAME; installing requirements"
mkvirtualenv $PROJECT_NAME
setvirtualenvproject $WORKON_HOME/$PROJECT_NAME $PROJECT_HOME/$PROJECT_NAME
workon $PROJECT_NAME

echo "Installing requirements from $PROJECT_HOME/$PROJECT_NAME"
pip3 install -r $PROJECT_HOME/$PROJECT_NAME/requirements.txt

echo "Ensuring contents of the 'export_venvwrapper_vars' script are present in bashrc of user 'vagrant'."
echo "This is necessary for virtualenvwrapper to work."
if [ $(grep -c -F --file=$PATH_EXPORT_VENVWRAPPER_SH $PATH_VAGRANT_USR_BASHRC) -lt \
     $(wc -l < $PATH_EXPORT_VENVWRAPPER_SH) ]; then
  printf "\n" >> $PATH_VAGRANT_USR_BASHRC
  cat $PATH_EXPORT_VENVWRAPPER_SH >> $PATH_VAGRANT_USR_BASHRC
fi

