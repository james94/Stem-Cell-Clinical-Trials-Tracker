
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import LoginPage from './components/LoginPage';
import SearchPage from './components/SearchPage';
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
import PatientWatchlistsPage from './components/PatientWatchlistsPage';
import ResearcherPage from './components/ResearcherPage';
import ResearcherInfoPage from './components/ResearcherInfoPage';
import WatchListPage from './components/WatchListPage';

function App() {
  return (
    <Router>
      <div>
        <Switch>
          <Route path="/search">
            <SearchPage />
          </Route>
          <Route path="/watch">
            <WatchListPage />
          </Route>
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
          <Route path="/discussion/:id" component={DiscussionForumInfoPage}>
            {/* <DiscussionForumInfoPage /> */}
          </Route>
          <Route path="/discussion">
            <DiscussionForumPage />
          </Route>
          <Route path="/phome">
            <PatientHomePage />
          </Route>
          <Route path="/patient/:id" component={PatientInfoPage}>
            {/* <PatientInfoPage /> */}
          </Route>
          <Route path="/patient">
            <PatientPage />
          </Route>
          <Route path="/pwatchlists/:id">
            <PatientWatchlistsPage />
          </Route>
          <Route path="/researcher/:id" component={ResearcherInfoPage}>
            {/* <ResearcherInfoPage /> */}
          </Route>
          <Route path="/researcher">
            <ResearcherPage />
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
