@extends('voyager::auth.master')

@section('content')
    <!-- .login-container -->
    <div class="login-container login_tab" style="@if(session('page')) display:none; @else display:block; @endif">
        <p style="font-size:20px;">Sign In</p>
        <form action="{{ route('voyager.login') }}" method="POST">
            {{ csrf_field() }}
            <div class="form-group form-group-default" id="emailGroup">
                <label>{{ __('voyager::generic.email') }}</label>
                <div class="controls">
                    <input type="email" name="email" id="email" placeholder="{{ __('voyager::generic.email') }}" class="form-control" value="admin@gmail.com" required>
                </div>
            </div>
            <div class="form-group form-group-default" id="passwordGroup">
                <label>{{ __('voyager::generic.password') }}</label>
                <div class="controls">
                    <input type="password" name="password" placeholder="{{ __('voyager::generic.password') }}" class="form-control" value="password" required>
                </div>
            </div>
            <div style="display:flex; justify-content:space-between;">
                <button type="submit" name="action" class="btn btn-block login-button">
                    <span class="signin">{{ __('voyager::generic.login') }}</span>
                </button>
                <button type="button" class="btn btn-block login-button register-btn" style="background:#fa2a00">
                    <span class="signin">Register</span>
                </button>
            </div>
        </form>
        <div style="clear:both"></div>
        @if(!$errors->isEmpty())
            <div class="alert alert-red" style="margin-top:20px;">
                <ul class="list-unstyled">
                    @foreach($errors->all() as $err)
                        <li>{{ $err }}</li>
                    @endforeach
                </ul>
            </div>
        @endif
    </div> 

    <!-- .register-container -->
    <div class="login-container register_tab" style="@if(session('page') == 'register') display:block; @else display:none; @endif">
        <p style="font-size:20px;">Register Form</p>
        <form action="{{ route('voyager.register') }}" method="POST">
            {{ csrf_field() }}
            <div class="form-group form-group-default" id="passwordGroup">
                <label>Name</label>
                <div class="controls">
                    <input type="text" name="name" placeholder="User Name" class="form-control" value="Khoghulan" required>
                </div>
            </div>
            <div class="form-group form-group-default" id="nameGroup">
                <label>{{ __('voyager::generic.email') }}</label>
                <div class="controls">
                    <input type="email" name="email" id="email-register" value="khoghukill@gmail.com" placeholder="{{ __('voyager::generic.email') }}" class="form-control" required>
                </div>
            </div>
            <div class="form-group form-group-default" id="passwordGroup">
                <label>{{ __('voyager::generic.password') }}</label>
                <div class="controls">
                    <input type="password" name="password" value="Kho3$prux" placeholder="{{ __('voyager::generic.password') }}" class="form-control" required
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                        title="Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 special character, and be at least 8 characters long.">
                </div>
            </div>
            <div style="display:flex; justify-content:space-between;">
                <button type="button" class="btn btn-block login-button login-btn">
                    <span class="signin">{{ __('voyager::generic.login') }}</span>
                </button>
                <button type="submit" class="btn btn-block login-button" style="background:#fa2a00">
                    <span class="signin">Register</span>
                </button>
            </div>
        </form>
        <div style="clear:both"></div>
        @if(session('error'))
            <div class="alert alert-red" style="margin-top:20px;">
                <ul class="list-unstyled">
                    <li>{{ session('error') }}</li>
                </ul>
            </div>
        @elseif(session('success'))
            <div class="alert alert-success" style="margin-top:20px;">
                <ul class="list-unstyled">
                    <li>{{ session('success') }}</li>
                </ul>
            </div>
        @endif
    </div>

    <!-- .verify-success-container -->
    <div class="login-container verification_success_tab" style="@if(session('page') == 'success_verification') display:block; @else display:none; @endif">
        <p style="font-size:30px; text-transform:none; text-align:center;">Welcome to Financial Budget Tracking System, Thank you for verifying your account. Please proceed with sign in.</p>
        <div style="margin-top:50px; display:flex; width:100%; justify-content:center;">
            <button class="btn btn-block login-button login-btn">
                <span class="signin">{{ __('voyager::generic.login') }}</span>
            </button>
        </div>
    </div>
    
    <!-- .verify-failed-container -->
    <div class="login-container verification_failed_tab" style="@if(session('page') == 'failed_verification') display:block; @else display:none; @endif">
        <p style="font-size:30px; text-transform:none; text-align:center;">Welcome to Financial Budget Tracking System, Your activation is Failed and Token Timeout. Please register again thank you.</p>
        <div style="margin-top:50px; display:flex; width:100%; justify-content:center;">
            <button class="btn btn-block login-button register-btn" style="background:#fa2a00">
                <span class="signin">Register</span>
            </button>
        </div>
    </div>
@endsection

@section('post_js')
    <script>
        var btn = document.querySelector('button[type="submit"]');
        var form = document.forms[0];
        var email = document.querySelector('[name="email"]');
        var password = document.querySelector('[name="password"]');
        var register_btns = document.querySelectorAll('.register-btn');
        var login_btns = document.querySelectorAll('.login-btn');
        var login = document.querySelector('.login_tab');
        var register = document.querySelector('.register_tab');
        var verification_success = document.querySelector('.verification_success_tab');
        var verification_failed = document.querySelector('.verification_failed_tab');

        // btn.addEventListener('click', function(ev){
        //     if (form.checkValidity()) {
        //         btn.querySelector('.signingin').className = 'signingin';
        //         btn.querySelector('.signin').className = 'signin hidden';
        //     } else {
        //         ev.preventDefault();
        //     }
        // });

        register_btns.forEach(register_btn => {
            register_btn.addEventListener('click', function() {
                register.style.display = 'block';
                login.style.display = 'none';
                verification_failed.style.display = 'none';
            });
        });

        login_btns.forEach(login_btn => {
            login_btn.addEventListener('click', function() {
                register.style.display = 'none';
                verification_success.style.display = 'none';
                login.style.display = 'block';
            });
        });

        email.focus();
        document.getElementById('emailGroup').classList.add("focused");

        // Focus events for email and password fields
        email.addEventListener('focusin', function(e){
            document.getElementById('emailGroup').classList.add("focused");
        });
        email.addEventListener('focusout', function(e){
            document.getElementById('emailGroup').classList.remove("focused");
        });

        password.addEventListener('focusin', function(e){
            document.getElementById('passwordGroup').classList.add("focused");
        });
        password.addEventListener('focusout', function(e){
            document.getElementById('passwordGroup').classList.remove("focused");
        });
    </script>
@endsection
