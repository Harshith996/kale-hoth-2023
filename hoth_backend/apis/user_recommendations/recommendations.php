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

        if ($pref["sex"] == 0) {
            $ideal_calorie_intake = 66 + 13.7 * $pref['weight'] * 0.453592 + 5 * $pref['height'] * 2.54 - 6.8 * 20;
        }
        else {
            $ideal_calorie_intake = 655 + 9.6 * $pref['weight'] * 0.453592 + 1.8 * $pref['height'] * 2.54 - 4.7 * 20;
        }
        if ($pref['health_index'] == 0) {
            $response["calorie_intake"] = $ideal_calorie_intake / 15;
        }
        else if ($pref['health_index'] == 1) {
            $response["calorie_intake"] = ($ideal_calorie_intake + 400) / 15;
        }
        else {
            $response["calorie_intake"] = ($ideal_calorie_intake - 400) / 15;
        }

        $result1 = $db->give_recommendations_breakfast($pref['carbon_index'], $pref["calorie_intake"], $pref['gluten'], $pref['vegan'], $pref['dairy']);
        $result2 = $db->give_recommendations_lunch($pref['carbon_index'], $pref["calorie_intake"], $pref['gluten'], $pref['vegan'], $pref['dairy']);
        $result3 = $db->give_recommendations_dinner($pref['carbon_index'], $pref["calorie_intake"], $pref['gluten'], $pref['vegan'], $pref['dairy']);


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
    $response['message'] = "Invalid Request";
}

echo json_encode($response);
?>