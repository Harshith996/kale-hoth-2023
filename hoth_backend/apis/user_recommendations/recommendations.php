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
        $result1 = $db->give_recommendations_breakfast($pref['carbon_index'], $pref["health_index"], $pref['gluten'], $pref['vegan'], $pref['diary']);
        $result2 = $db->give_recommendations_lunch($pref['carbon_index'], $pref["health_index"], $pref['gluten'], $pref['vegan'], $pref['diary']);
        $result3 = $db->give_recommendations_dinner($pref['carbon_index'], $pref["health_index"], $pref['gluten'], $pref['vegan'], $pref['diary']);

        if ($result1 == -1 or $result2 == -1 or $result3 == -1) {
            $response['error'] = true;
            $response['message'] = 'Something went wrong';
        }

        else
        {
            $response['error'] = false;
            $i = 0;
            $breakfast = array();
            while($row = $result->fetch_assoc())
            {
                if ($i == 5){
                    // to get 3 best meals
                    continue;
                }
                $breakfast[$i] = $row;
                $i = $i + 1;
            }
            $response['breakfast'] = $breakfast;

            $i = 0;
            $lunch = array();
            while($row = $result->fetch_assoc())
            {
                if ($i == 5){
                    // to get 3 best meals
                    continue;
                }
                $lunch[$i] = $row;
                $i = $i + 1;
            }
            $response['lunch'] = $lunch;

            $i = 0;
            $dinner = array();
            while($row = $result->fetch_assoc())
            {
                if ($i == 5){
                    // to get 3 best meals
                    continue;
                }
                $dinner[$i] = $row;
                $i = $i + 1;
            }
            $response['dinner'] = $dinner;
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
    $response['message'] = "Invalid Request! Something went wrong.";
}

echo json_encode($response);
?>