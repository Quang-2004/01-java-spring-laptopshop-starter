const formWrapper = document.querySelector('.form-wrapper');
const toSignUp = document.querySelector('#toSignUp');
const toLogin = document.querySelector('#toLogin');

// Event listener to slide to Sign Up
toSignUp.addEventListener('click', (e) => {
    e.preventDefault();
    formWrapper.style.transform = 'translateX(-50%)';
});

// Event listener to slide back to Login
toLogin.addEventListener('click', (e) => {
    e.preventDefault();
    formWrapper.style.transform = 'translateX(0)';
});
