<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Hash;
use Illuminate\Notifications\Notifiable;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Session;
use App\Notifications\RegisterUser;
use App\Models\User;

class UserController extends Controller
{
    use Notifiable;

    public function routeNotificationForMail() {
        return request()->email;
    }
    
    /**
     * Handle a register request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\View
     */
    public function postRegister(Request $request)
    {
        try {
             // Validation rules (customize these according to your needs)
            $validatedData = $request->validate([
                'name' => 'required',
                'email' => 'required|email|unique:users',
                'password' => 'required|min:8',
            ]);

            // Prepare data for creating a new user
            $userData = [
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => Hash::make($validatedData['password']),
            ];

            // Create a new user
            $newUser = User::create($userData);

            $this->notify(new RegisterUser($newUser->id));

            return back()->with([
                'success' => 'An email was send to your email address for verification',
                'page' => 'register'
            ]);

        } catch (\Exception $e) {
        
            return back()->with([
                'error' => $e->getMessage(),
                'page' => 'register'
            ]);
        }
      
    }

    /**
     * Handle a verify request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\View
     */
    public function verify(Request $request) 
    {
        $currentDateTime = now();

        // Convert the timestamp to a Carbon instance
        $timestampDateTime = Carbon::createFromTimestamp($request->query('expires'));

        $user = User::find($request->query('id'));

        $url = 'http://127.0.0.1:8000/admin/login';

        if($user->email_verified_at){
            return redirect($url);
        } else {
            if($user && $currentDateTime->lt($timestampDateTime)){
                $user->email_verified_at = now();
                $user->save();
                Session::flash('page', 'success_verification');
                return redirect($url)->with('page', 'success_verification');
            } else {
                if($user){ $user->delete(); }
                Session::flash('page', 'failed_verification');
                return redirect($url)->with('page', 'failed_verification');
            }
        }
    }
}