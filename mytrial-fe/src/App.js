
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
import EditPatients from './components/EditPatients';


function App() {
  return (
    <Router>
      <div>
        <Switch>
          <Route path="/login">
            <LoginPage />
          </Route>
          <Route path="/register">
            <RegisterPage />
          </Route>
          <Route path="/rhome">
            <ResearcherHomePage />
          </Route>
          <Route path="/trials/:id">
            <TrialInfoPage />
          </Route>
          <Route path="/trials">
            <TrialsPage />
          </Route>
          <Route path="/addtrial">
            <CreateTrialPage />
          </Route>
          <Route path='/editpatients'>
            <EditPatients />
          </Route>
          <Route path="/">
            <LandingPage />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

export default App;
