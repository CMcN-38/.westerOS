{...}: {

    programs.ssh = {
        extraConfig = "
            Host hightower
                Hostname 192.168.4.96
                Port 22
                User cameron
            Host lannister
                Hostname 192.168.4.121
                Port 22
                User cameron
        ";
    };

}
