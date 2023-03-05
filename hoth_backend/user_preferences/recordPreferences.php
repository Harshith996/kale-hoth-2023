<?php
    // ini_set('display_errors', 1);
    // ini_set('display_startup_errors', 1);
    // error_reporting(E_ALL);
    require_once '../../includes/DbOperation.php';
    $response = array();
    if($_SERVER['REQUEST_METHOD'] == 'POST')
    {
        if(
            isset($_POST['user_id'])
            and isset($_POST['height'])
            and isset($_POST['weight'])
            and isset($_POST['sex'])
            and isset($_POST['health_index'])
            and isset($_POST['carbon_index'])
        )
        {
            $db = new DbOperation();

            $result = $db->record_preferences($_POST['user_id'], $_POST['height'], $_POST['weight'], $_POST['sex'], $_POST['health_index'], $_POST['carbon_index']);

            if($result == -1)
            {
                $response['error'] = true;
                $response['message'] = 'Sometihng went wrong';
            }

            else
            {
                $response['error'] = false;
                $response['message'] = 'User prefs registered successfully';
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