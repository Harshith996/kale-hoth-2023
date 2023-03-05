<?php

    require_once '../../includes/DbOperation.php';
    $response = array();
    if($_SERVER['REQUEST_METHOD'] == 'POST')
    {
        if(
            isset($_POST['user_id'])
            and isset($_POST['first_name'])
            and isset($_POST['last_name'])
            and isset($_POST['email'])
            and isset($_POST['password'])
        )
        {
            $db = new DbOperation();

            $result = $db->update_user_profile($_POST['user_id'], $_POST['first_name'], $_POST['last_name'], $_POST['email'], $_POST['password']);

            if($result == -1)
            {
                $response['error'] = true;
                $response['message'] = 'Something went wrong';
            }
            else
            {
                $response['error'] = false;
                $response['message'] = 'User profile updated';
            }
        }
        else
        {
            $response['error'] = true;
            $response['message'] = 'Required Fields are missing';
        }
    }
    else
    {
        $response['error'] = true;
        $response['message'] = "Invalid Request";
    }

    echo json_encode($response);
?>