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

        $pref = $db->get_user_preferences($_POST['user_id']);
        $result = $db->no_gluten_filter($pref['carbon_index'], $pref["health_index"]);


        if ($result == -1) {
            $response['error'] = true;
            $response['message'] = 'Something went wrong';
        }

        else
        {
            $response['error'] = false;
            $i = 0;
            $recommendations = array();
            while($row = $result->fetch_assoc())
            {
                if ($i == 5){
                    // to get 5 best meals
                    continue;
                }
                $recommendations[$i] = $row;
                $i = $i + 1;
            }
            $response['recommendations'] = $recommendations;
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
    $response['message'] = "Invalid Request";
}

echo json_encode($response);
?>