<?php

require_once '../../includes/DbOperation.php';
    $response = array();
    if($_SERVER['REQUEST_METHOD'] == 'POST')
    {
        if(isset($_POST['email']) and isset($_POST['password']))
        {
            $db = new DbOperation();
            
            if($db->userLogin($_POST['email'], $_POST['password']))
            {
                $user = $db->getUserByUsername($_POST['email']);

                $response['error'] = false;
                $response['user_id'] = $user->fetch_assoc()['user_id'];
                $response['email'] = $_POST['email'];
                $response['password'] = $_POST['password'];
                $response['message'] = "Login Successful";
            }
            else
            {
                $response['error'] = true;
                $response['message'] = "Please fill in the correct details";
            }
        }
        else
        {
            $response['error'] = true;
            $response['message'] = 'Required Fields are missing';
        }
    }

    echo json_encode($response);

?>