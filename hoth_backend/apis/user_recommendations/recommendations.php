<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once '../../includes/DbOperation.php';
$response = array();
if($_SERVER['REQUEST_METHOD'] == 'POST')
{
    if(
        isset($_POST['user_id'])
    )
    {
        $db = new DbOperation();

        $pref = $db->get_user_preferences($_POST['user_id']);
        var_dump($pref);

        $response['error'] = false;
        $i = 0;
        //$breakfast = array();
        // while($row = $breakfast->fetch_assoc())
        // {
        //     if ($i == 5){
        //         // to get 3 best meals
        //         continue;
        //     }
        //     $breakfast[$i] = $row;
        //     $i = $i + 1;
        // }
        // $response['breakfast'] = $breakfast;

        // $i = 0;
        // $lunch = array();
        // while($row = $lunch->fetch_assoc())
        // {
        //     if ($i == 5){
        //         // to get 3 best meals
        //         continue;
        //     }
        //     $lunch[$i] = $row;
        //     $i = $i + 1;
        // }
        // $response['lunch'] = $lunch;

        // $i = 0;
        // $dinner = array();
        // while($row = $dinner->fetch_assoc())
        // {
        //     if ($i == 5){
        //         // to get 3 best meals
        //         continue;
        //     }
        //     $dinner[$i] = $row;
        //     $i = $i + 1;
        // }
        // $response['dinner'] = $dinner;


        $output = exec('ai.py');
        echo $output;
        $response['message'] = 'Preferences recovered successfully';
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