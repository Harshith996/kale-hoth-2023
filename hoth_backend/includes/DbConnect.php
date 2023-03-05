<?php
    class DbConnect
    {
        private $con;
        function __construct()
        {
            
        }
        function connect()
        {
            include_once 'Constants.php';
            $this->con = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
            if(mysqli_connect_error())
            {
                echo 'Failed to connect with Database';
            }
            return $this->con;
        }
    }
?>