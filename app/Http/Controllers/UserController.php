<?php

namespace App\Http\Controllers;

use TCG\Voyager\Http\Controllers\VoyagerAuthController;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\Request;
use App\Models\User;

class UserController extends VoyagerAuthController
{
    /**
     * Handle a login request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function postLogin(Request $request)
    {
        $this->validateLogin($request);


        if ($this->hasTooManyLoginAttempts($request)) {
            $this->fireLockoutEvent($request);

            return $this->sendLockoutResponse($request);
        }

        $credentials = $this->credentials($request);

        // $user = User::where('email', $request->email)->first();

        // if ($user && ! $user->email_verified_at) {

        //     $this->incrementLoginAttempts($request);

        //     throw ValidationException::withMessages([
        //         'email' => ['Please verify your acccount with registered email.'],
        //     ]);
        // }

        if ($this->guard()->attempt($credentials, $request->has('remember'))) {

            return $this->sendLoginResponse($request);
        }

        $this->incrementLoginAttempts($request);

        return $this->sendFailedLoginResponse($request);
    }

    /**
     * Handle a register request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function postRegister(Request $request)
    {
        
    }
}