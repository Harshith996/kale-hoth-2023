<?php
    require_once '../../includes/DbOperation.php';
    $response = array();
    if($_SERVER['REQUEST_METHOD'] == 'POST')
    {
        if(
            isset($_POST['first_name'])
            and isset($_POST['last_name'])
            and isset($_POST['email'])
            and isset($_POST['password'])
        )
        {
            $db = new DbOperation();

            $result = $db->create_user($_POST['first_name'], $_POST['last_name'], $_POST['email'], $_POST['password']);

            if($result == 2)
            {
                $response['error'] = true;
                $response['message'] = 'User registration unsuccessful';
            }
            else if($result == 0)
            {
                $response['error'] = true;
                $response['message'] = 'User already exists';
            }
            else
            {
                $user = $db->getUserByUsername($_POST['email']);
                $response['error'] = false;
                $response['user_id'] = $user->fetch_assoc()['user_id'];
                $response['first_name'] = $result['first_name'];
                $response['last_name'] = $result['last_name'];
                $response['email'] = $result['email'];
                $response['message'] = 'User registered successfully';
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