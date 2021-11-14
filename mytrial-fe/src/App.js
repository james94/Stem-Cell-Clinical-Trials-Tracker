
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import LoginPage from './components/LoginPage';
import RegisterPage from './components/RegisterPage';
import LandingPage from './components/LandingPage';
import ResearcherHomePage from './components/ResearcherHomePage';
import TrialsPage from './components/TrialsPage';
import TrialInfoPage from './components/TrialInfoPage';
import CreateTrialPage from './components/CreateTrialPage';
import DiscussionForumPage from './components/DiscussionForumPage';
import DiscussionForumInfoPage from './components/DiscussionForumInfoPage';
import PatientHomePage from './components/PatientHomePage';
import PatientPage from './components/PatientPage';
import PatientInfoPage from './components/PatientInfoPage';
import EditPatientPage from './components/EditPatientPage';
import PatientWatchlistsPage from './components/PatientWatchlistsPage';
import ResearcherPage from './components/ResearcherPage';
import ResearcherInfoPage from './components/ResearcherInfoPage';
import Top from './components/Top';

function App() {
  return (
    <Router>
      <div>
        <Switch>
          <Route path="/login">
            <Top />
            <LoginPage />
          </Route>
          <Route path="/register">
            <Top />
            <RegisterPage />
          </Route>
          <Route path="/rhome">
            <Top />
            <ResearcherHomePage />
          </Route>
          <Route path="/trials/:id">
            <Top />
            <TrialInfoPage />
          </Route>
          <Route path="/trials">
            <Top />
            <TrialsPage />
          </Route>
          <Route path="/addtrial">
            <Top />
            <CreateTrialPage />
          </Route>
          <Route path="/discussion/:id" component={DiscussionForumInfoPage}>
            {/* <DiscussionForumInfoPage /> */}
          </Route>
          <Route path="/discussion">
            <Top />
            <DiscussionForumPage />
          </Route>
          <Route path="/phome">
            <Top />
            <PatientHomePage />
          </Route>
          <Route path="/patient/:id" component={PatientInfoPage}>
            {/* <PatientInfoPage /> */}
          </Route>
          <Route path="/editPatient/:id">
            <EditPatientPage />
          </Route>
          <Route path="/patient">
            <Top />
            <PatientPage />
          </Route>
          <Route path="/pwatchlists/:id">
            <Top />
            <PatientWatchlistsPage />
          </Route>
          <Route path="/researcher/:id" component={ResearcherInfoPage}>
            {/* <ResearcherInfoPage /> */}
          </Route>
          <Route path="/researcher">
            <Top />
            <ResearcherPage />
          </Route>
          <Route path="/">
            <Top />
            <LandingPage />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

export default App;
