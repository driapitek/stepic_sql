select * from billing;

insert into billing values (
  'pasha@mail.com',
  'katya@mail.com',
  '300.00',
  'EUR',
  '2016-02-14',
  'Valentines day present)');
  
select * from billing where payer_email = 'alex@mail.com';

DELETE FROM billing WHERE payer_email is NULL or recipient_email is NULL;
