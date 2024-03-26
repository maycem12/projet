const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'votre_email@gmail.com', // Laissez cette ligne telle quelle
    pass: 'votre_mot_de_passe'     // Laissez cette ligne telle quelle
  }
});

exports.sendEmailToAdmin = functions.auth.user().onCreate(async (user) => {
  try {
    await transporter.sendMail({
      from: `"${user.displayName}" <${user.email}>`, // Utilisez le nom et l'email de l'utilisateur qui s'inscrit
      to: 'maycem.benlagha@gmail.com',                // Adresse e-mail de l'administrateur
      subject: 'Nouvel utilisateur inscrit',
      text: `Un nouvel utilisateur s'est inscrit. Email : ${user.email}`
    });
    console.log('E-mail envoyé à l\'administrateur');
  } catch (error) {
    console.error('Erreur lors de l\'envoi de l\'e-mail à l\'administrateur:', error);
  }
});
