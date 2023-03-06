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
            $response['vegan'] = $result['vegan'];
            $response['gluten'] = $result['gluten'];
            $response['dairy'] = $result['dairy'];
            $response['message'] = 'Preferences recovered successfully';
        }
        if ($result["sex"] == 0) {
            $ideal_calorie_intake = 66 + 13.7 * $result['weight'] * 0.453592 + 5 * $result['height'] * 2.54 - 6.8 * 20;
        }
        else {
            $ideal_calorie_intake = 655 + 9.6 * $result['weight'] * 0.453592 + 1.8 * $result['height'] * 2.54 - 4.7 * 20;
        }
        if ($result['health_index'] == 0) {
            $calorie_intake = $ideal_calorie_intake / 15;
        }
        else if ($result['health_index'] == 1) {
            $calorie_intake = ($ideal_calorie_intake + 400) / 15;
        }
        else {
            $calorie_intake = ($ideal_calorie_intake - 400) / 15;
        }
        $calorie_up = $calorie_intake + 100;
        $calorie_down = $calorie_intake - 100;
        $python_call = array($calorie_up, $calorie_down, $result['carbon_index'], $result['vegan'], $result['gluten'], $result['dairy']);
        $py = json_encode($python_call);
        $args = "" . $calorie_down . "," . $calorie_up . "," .  $result['carbon_index'] . "," .  $result['vegan'] . "," .  $result['gluten'] . "," .  $result['dairy'];

        $cmd = "python3 ./ai.py " . $args;
        $command = escapeshellcmd($cmd); #no special characters it will work

        $output = shell_exec($command);
        $array = json_decode($output);
        $response["dinner"] = $array;
        $response["dinner_dining_hall"] = "Epicuria";


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