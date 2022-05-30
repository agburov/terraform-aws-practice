#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

cat <<EOF > /var/www/html/index.html
<html>
  <head>
    <meta charset="utf-8">
    <title>Build by Terraform</title>
  </head>
  <body>

    Template page with owner ${f_name} ${l_name} <br>

    %{for x in colegues ~}
      List of colegues with name ${x} <br>
    %{endfor ~}

  </body>
</html>
EOF
