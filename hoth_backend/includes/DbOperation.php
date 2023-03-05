<?php

    date_default_timezone_set('America/Los_Angeles');
    class DbOperation
    {
        private $con;
        function __construct()
        {
            require_once 'DbConnect.php';
            $db = new DbConnect();
            $this->con = $db->connect();
        }
        
        ////////////////////////////////////////////////////////////////////////
        
        // Core Functions

        private function is_user_exist($email)
        {
            $stmt = $this->con->prepare("SELECT user_id FROM users WHERE email = ?");
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $stmt->store_result();

            return $stmt->num_rows > 0;
        }
        public function create_user($first_name, $last_name, $email, $pass)
        {
            if($this->is_user_exist($email))
            {
                return 0;
            }
            else
            {
                $password = md5($pass);
                $query = "INSERT INTO `users`(`user_id`, `first_name`, `last_name`, `email`, `password`) VALUES (NULL, ?, ?, ?, ?)";
                $stmt = $this->con->prepare($query);
                $stmt->bind_param("ssss", $first_name, $last_name, $email, $password);
                if($stmt->execute()){
                    $values['first_name'] = $first_name;
                    $values['last_name'] = $last_name;
                    $values['email'] = $email;
                    return $values;
                }
                else
                {
                    return 2;
                }
            }
        }
        public function getUserByUsername($email)
        {
            $stmt = $this->con->prepare("SELECT * FROM users WHERE email = ?");
            $stmt->bind_param("s", $email);
            if($stmt->execute())
            {
                return $stmt->get_result();
            }
            else
            {
                return 0;
            }
        }
        public function userLogin($email, $pass)
        {
            $password = md5($pass);
            $stmt = $this->con->prepare("SELECT user_id FROM users WHERE email = ? AND password = ?");
            $stmt->bind_param("ss", $email, $password);
            $stmt->execute();
            $stmt->store_result();
            return $stmt->num_rows > 0;
        }
        public function update_user_profile($user_id, $first_name, $last_name, $email, $pass)
        {
            $password = md5($pass);
            $query = "UPDATE `users` SET `first_name`=?, `last_name`=?, `email`=?, `password`=? WHERE user_id = ?";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("sssss", $first_name, $last_name, $email, $password, $user_id);
            if($stmt->execute()){
                return 0;
            }
            else
            {
                return 2;
            }
        }

        /////////////////////////////////////////////////
        // User Preferences
        public function record_preferences($user_id, $height, $weight, $sex, $health_index, $carbon_index)
        {
            $query = "INSERT INTO `user_preferences`(`preference_id`, `user_id`, `height`, `weight`, `sex`, `health_index`, `carbon_index`) VALUES (NULL, ?, ?, ?, ?, ?, ?)";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("ssssss", $user_id, $height, $weight, $sex, $health_index, $carbon_index);
            if($stmt->execute()){
                return 0;
            }
            else
            {
                return -1;
            }
        }
        public function get_user_preferences($user_id)
        {
            $query = "SELECT * FROM user_preferences WHERE user_id = ?";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("s", $user_id);
            $stmt->execute();
            return $stmt->get_result()->fetch_assoc();
        }
    }

    public function give_recommendations_breakfast($carbon_index, $health_index, $gluten, $vegan, $dairy)
        {
            $query = "SELECT * FROM food_data WHERE carbonfp = ? AND health = ? AND meal_type in (1,4)
            AND gluten = ? AND vegan = ? AND dairy = ?";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("iiiii", $carbon_index, $health_index, $gluten, $vegan, $dairy);
            $stmt->execute();
            $result = $stmt->get_result();
            return $result;

        }

        public function give_recommendations_lunch($carbon_index, $health_index, $gluten, $vegan, $dairy)
        {
            $query = "SELECT * FROM food_data WHERE carbonfp = ? AND health = ? AND meal_type in (2,4,5) 
            AND gluten = ? AND vegan = ? AND dairy = ?";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("iiiii", $carbon_index, $health_index, $gluten, $vegan, $dairy);
            $stmt->execute();
            $result = $stmt->get_result();
            return $result;

        }

        public function give_recommendations_dinner($carbon_index, $health_index, $gluten, $vegan, $dairy)
        {
            $query = "SELECT * FROM food_data WHERE carbonfp = ? AND health = ? AND meal_type in (3,4,5)
            AND gluten = ? AND vegan = ? AND dairy = ?";
            $stmt = $this->con->prepare($query);
            $stmt->bind_param("iiiii", $carbon_index, $health_index, $gluten, $vegan, $dairy);
            $stmt->execute();
            $result = $stmt->get_result();
            return $result;

        }

?>