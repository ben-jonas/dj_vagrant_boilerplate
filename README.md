# dj_vagrant_boilerplate

Initial project setup for a new Django app served with gunicorn / nginx, designed for quick provsioning with Vagrant. Idealy one would use this for a hackathon project or quick prototype that can be developed further without too much pain.

Note that the the gunicorn sevice is initialized through the host's vagrant provisioning, NOT enabled on the guest VM through systemd.
