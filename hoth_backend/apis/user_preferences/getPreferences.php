<?php
require_once '../../includes/DbOperation.php';
$response = array();
if($_SERVER['REQUEST_METHOD'] == 'POST')
{
    if(
        isset($_POST['user_id'])
    )
    {
        $db = new DbOperation();

        $result = $db->get_user_preferences($_POST['user_id']);

        if($result == -1)
        {
            $response['error'] = true;
            $response['message'] = 'Something went wrong';
        }
        else
        {
            $response['error'] = false;
            $response['user_id'] = $_POST['user_id'];
            $response['height'] = $result['height'];
            $response['weight'] = $result['weight'];
            $response['sex'] = $result['sex'];
            $response['health_index'] = $result['health_index'];
            $response['carbon_index'] = $result['carbon_index'];
            $response['message'] = 'Preferences recovered successfully';
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
    $response['message'] = "Invalid Request. Something went wrong!";
}

echo json_encode($response);

?>