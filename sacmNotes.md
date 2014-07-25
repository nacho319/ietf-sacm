# SACM Meeting Notes
### 22-July-2014

## Dan R. (Chair) -
 * plan is to present issues today
 	+ work through issues and build agreement between now and Friday
 * Friday is another meeting to make progress with consensus
 * Go to NSaaS Bar BOF to see if NSaaS is in scope after Bits N Bytes
 
## Architecture Draft

NCW - presenting

Dan R (contrib) - Is there an admin
	NCW - an application type could be an admin type just giving housekeeping (auth, service location, etc.)
	Dan R. - in previous diagrams there was always an admin function with the sensors; but admin functions aren't always colocated in all locations.
	NCW - the architecture supports colocating functions; and for small scale deployments that may make sense, but in large scale deployments that is separable
	
Dave W. - We previously talked about using multiple various procotols, but with new broker definition, it doesn't appear that we are supporting using those various protocols, (NETCONF, SNMP, etc.)
	NCW - yes that is considered in the architecture; but the text is missing;  future control plane will allow specification of the transport and data model to support more protocols
	
Dan R. - that is text that needs to be expanded; to clearly define transport & data model are separable and selectable
	NCW - yes, currently there is only one sentence and it needs to be expanded; some text got inadvertently dropped
	
NCW - PLEASE PLEASE provide more feedback
_action item_ NCW - clarify difference between roles and functions

Lisa L - The TNC proposal was supposed to provoke discussion on these topics 

## Information Model

DW - presenting

Dan R. (chair) - Does this turn into feedback and input into the architecture work?  (how are they captured)
	Dave W. - yes they do feedback to the arch work
	Dan R. - this is another action item for the week to get this feedback into the architecture work
	
Brian F. - Can you define what an endpoint includes?  Does it include device connectivity, (wireless vs. wired devices)
	Dave W. - It's defined in the terminology draft; anything that is connected to "network"
	
Dan R. (contrib) - you focus on Asset ID's a bunch…
	Dave W. - yes…

Dan R (contrib) - believes that these categories are "kinda right".  Is there prior art/work in IETF or other places for these IE's?
	Dave W. - yes, we believe there is prior art for all these areas; but the gap that exists in current draft is in TASKING; HW identification is also hard to find existing work
	Dan R (contrib) - ITU has an existing 600 item list to describe HW; it's in the Alarm MIB
	
[ed] Would like to understand what data models will be required to implement?  Would like to have statements in the requirements/architecture draft.

Jim B - What does source vendors vs. 3rd party vendor
	Dave W. - source vendor would be a vendor who sells software (Microsoft, Adobe, Cisco, etc.); 3rd party provider would be a software security vendor (tripwire, McAfee, Symantec, etc.) that catalogs other vendors software
	Jim B - Why?
	Dave W. - scales better if vendors are supporting model directly, as opposed to both
	Adam M (contrib) - agrees we need to support those use cases; but are they separate?
	Dave W - we do in order to scale the system and allow people to model this
	[ed] - even more important in note takers opinion; need mechanism to deconflict multiple model statements on the same item
	

## TNC-Based Information Model

Lisa L - presenting

Dan R (chair)  - Did you read RFC on difference between data model and information model
	Lisa L - yes we did; but still challenging to separate a combined model in IF-MAP into a separate info/data model; so still VERY draft
	
Famiha - How do you capture information from the endpoint into the repository?
	Lisa L - not originally considered in the TCG information; original design got info into repo via aggregators, but customers wanted info directly from endpoint;
	
Dave W - Map clients are not just consumers of info, but potentially producers
	Lisa L - absolutely, IDS, phones, etc.
	
Brian F - NEA didn't have any these components; it really had NAC interfaces
	Lisa L - correct, NAC was there; adding security automation
	Brian F - So where does NEA fit?
	Lisa L - in visibility and enforcement
	Dave W - NEA is a potential data source for SACM
	
[ed] biggest point that building something extensible for unimagined use cases is the key
[ed] desgined IF-MAP 7 years ago;  XML over SOAP was acceptable then; would like a better protocol (more realtime, etc.) to enable more functionality now
[ed] Boeing extended system for MAP clients tied into overlay networks to solve unplanned for problems

Brian F - All defined within the required domain?  Still always in the LAN?
	Lisa L - Could be in the domain, but information might be from federated MAP graphs (MAP graphs coming up)
	Lisa L - Defining domains and MAP graphs is really hard, not totally solved


Brian F - Identifier: If an asset management system is in place, doesn't that define the identifiers?
	Lisa L - it would be the starting point; but an asset might have multiple identifiers associated with it, various IP's, etc.
	Brian F - but that asset mgmt system would be authoritative
	Lisa L - it would publish into the MAP system, but they can be different
	
Dan R - This is a arch definition, and wondering how this is the same/different from Nancy's arch;
	clients in TNC are endpoints in SACM arch?
	Lisa L - no, clients are functional, might be an endpoint, might not
	
Dave W - Search requires persistence; how is information persisted
	Lisa L - in TNC there is the concept of lifetime;  some set of information is defined for as long as a map client is connected, but others must be purged in the system
	Dave W - An information provider is an information owner
	Lisa L - it is, but there are different levels of authoritativeness; DHCP server likely authoritative, but could have other sources of that information
	
Dan R (chair) - Vendor extension; did you read Dave W.'s concept of catalogs?
	Lisa L - yes, that's a problem that TNC didn't tackle, and needs
	
Dave W - Objects are effectively vertexes.
	Lisa L - edges are the relationships between vertexes.  the links.
	Dave W - Is metadata a vertex in its own right?
	Lisa L - you can have a metadata item attached to a vertex (identifier) as a policy item, but it could also be applied to a link applying the policy when an endpoint is connected to some other device.

Brian F - What happens with endpoint in office with VM machine with virtual switch, with multiple VM's running
	Lisa L - exactly, but each VM has a network session, each is its own node; but a VPN tunnel is more complicated, both an internal and external connection
	Steve V - mobility of a session is even more complicated, e.g. when network connectivity changes, but the session persists
	Lisa L - yes when you want it to supersede an existing node
	Steve V - one of the advantages is that when a state change happens, then all subscribers are updates
	
Dave W - For all data published to the MAP is there a source identifier?
	Lisa L - when you publish data in IF-MAP, everything has a publisher ID, but its hard to retrieve, which is a problem
	Dave W - needs some method of proving source
	
Jim ?? - freshness - is the concept of time captured in the MAP
	Lisa L - in IF-MAP there is a time of publish of data, but its a weakness and should be improved in SACM

Dan R (chair) - part of this is TNC work?
	Lisa L - this is not TNC work directly; it is based on open published standards; not submitting their standards as candidate proposals
	Dan R - have you (Lisa) and David read each others proposals
	Lisa & Dave - both high level read so far, not detailed
	Dan R - sit down in next few days and attempt to create a unification proposal
	Lisa L - believes it should be fair simple to combine the models, but it will be big
	Dave W - sounds good, let's find a time to meet up, coordinate immediately after meeting


## XMPP extensions for SACM

Svaya - presenting

Dave W - is a subtopic essentially a link to a topic applying a filter? e.g. if interested in software change events on a specific filter, would there be a topic of software change events, and then a subtopic of interest in a specific network.
	Savya - Yes, the example is essentially correct; the controller creates the subtopic and the publisher publishes on both the topic and subtopic
Brian F - XMPP is providing the security to the messages though?
	NCW - XMPP is providing security on the messages; but there is another layer of security the controller is providing to prevent sensitive information going to restricted destinations.
	
Dan R (chair) - XMPP relies very much on XMPP server and controller.  How do you protect against attacks on the server & controller?
	NCW - Some of that is implementation specific;  So the controller would have to protect itself from flooding itself, over subscription.
	
Kathleen M - Thanks for bringing in new proprosals; there are some security issues in XMPP, and XMPP is working on the security issues, but the XMPP working group needs help.

Adam M - XMPP-Grid is referenced a lot, but there is no reference to that "standard"
	NCW - XMPP-Grid is basically a build on top of XMPP; need appropriate references to XMPP; authors will correct.
	



* * * 


# SACM meeetup notes #
### 22-July-2014

## Architecture Conversation

* Better defining the roles of repositories of attribute data
	+ 1
	+ 2
	+ 3

* Types of Repositories
	+ Guidance - more traditional SCAP data for policies, etc.
	+ Posture attribute data - collected data
	+ Evaluation results data -
	+ observed behavior - (same as posture data??) network sensors, etc.

* Previously engaging previous IETF work
	+ NEA
 	+ …
 	+ proxies - mediators to other data sources possibly (NEA, etc.)
 	+ a

* Differentiate:
	+ roles - provider / consumer
	+ capabilities - e.g. can provide guidance
	+ function - 

* Control plane interfaces

* Differentiate:
	+ Broker
	+ Proxy
	+ Data provider

* Timing is an issue <- requirements issue

* how to deal with delegation, especially in pub/sub model

* * *

# SACM meetup notes #
### 24-July-2014 ####



* * *

# SACM Meeting Notes #
### 25-July-2014 ###

* Agenda Bash
	+ Net Security As Service first


## Network Security as a Service ##
### Presenter: Linda Dunbar


* Dan .R (contrib)
	+ IETF is starting to work with more opensource organizations (I2RS, others . . .) developing code for issues.  This helps the IETF determine what the part that needs to be standardized in a manageable amount of time.  SACM is working on a purposefully constrained problem statement (endpoints, using IETF standards).  NSaaS doesn't have that well defined problem statement that is ready for a WG yet.
	+ Linda D. - sacm is doing good work, but worried about confusion it 
	+ Kathleen M. (AD) - like idea, but needs more development, maybe able to get to a BoF for next meeting.  Kathleen would like to keep BoF in touch with sacm for crossover.
	+ Ronald G - Is diameter a possible alternative to this protocol?
		* Linda - that would be the first protocol to examine.  PCI is using diameter, but needs extension?
		* Ronald G - where would diameter be extended
		* Linda - still too early.
	+ NCW - Still too early for this work; the work from sacm would matter as possible input to how do you react state change and change posture. Worried about 
	+ Dave W - An endpoint is ANYTHING that is network connected.  managing physical or virtual is in scope to SACM.  So managing both virtual and physical does matter and it would have advantages.  It would help if you (Linda) could help us know the differences between virtual and physical managements
		* Linda - more than just managing the device, but the negotiation between purchasing entity and provider
		* Kathleen - NSaaS includes more service negotiation (security, availability, etc.) not just configuration

## Requirements ##
### Presenter: Lisa L

_Displaying Doc Diff_

* NCW - let's call it __time stamping__ instead of __synchronization__ because we're not good at __synchronization__ and it implies a lot more stuff.
	+ Lisa - that's fine, it was originally __time stamping__

* Area of requested feedback: 2.3 requirements for information model
	+ uniqueness of objects - or mechanism for disambiguating "similar" objects (e.g. 10.0.0.1 multiple times)
	+ support for rootless searches -
		* Dan R (contrib) - is this a info model requirement, data model requirement, or maybe a tool requirements?
		* NCW - is it a requirement for the sets of functions we want
		* Dan R (contrib) - should we then break 2.3 into requirements between InfoModel & DataModel
		* NCW - will work with Lisa on bucketing appropriately
		* Dave W - maybe need better definition of what needs search capability, to refine the implications
		* Lisa - 
	+ Dave W - are we expressing a policy about data lifetime from a provider, or describing what the collector should keep/how long
		* Lisa - data should express how long it is valid (maybe…)
		* Dave W - customer reqs would vary here
		* Lisa - yes, need to refine statement between publisher vs collector data storage lifetime
		* Jim B - use case of retrospective analysis of data; need to express the policy of how long collected storage of data should be kept
	+ Chris I - cardinality (of an observation replacing another) is non-existent
		* NCW & Jim B - with time stamping & uniqueness, then there is never an _identical_ reporting, so no replacement
		* Mike B - thinks there might be a case for this, but can't think of it off the top of its head
	+ NCW - versioning will be needed at all levels, so not an InfoModel req per se, but global
	+ Jim B - data provenance, identity & time are the largest key points; important to be able to indicate an observation vs. an evaluation; (who & when) are the most key points; the rest are "nice" to have
		* Lisa - the other pieces are nice to have, especially if you trust your environment
		* Dave W - need a method to express provenance information; possibly that set of information could be an IANA reg
		* NCW - should be a consideration, not necessarily a requirement
	+ Dan R (contrib) - would like a better word than "freshness"
		* Lisa is fine with using a better term, group please provide
	+ Dave W - collection composition - might want to have compostion and decomposition of requests, two sides of same coin, about how to split combine requests
		* group: generally agreement
		

## Architecture ##
### Presenter: NCW ###

+ Adam M (contrib) - will do updates to the terminology draft
	 * Role, capability, baseline, guideline, control plane
	 * Dave W - add _data plane_ too
	 * Kathleen M (AD) - do not redefine those terms, reference to other established terms
	 * NCM - define client/supplicant too?
	 
* Dave W - Is requestor going to be changed to consumer in draft
	+ NCW - yes, because we like to change it in every draft revision

* Kathleen M (AD) - In XMPP you might pass through multiple XMPP servers because its federated
	+ NCW - in the control plane, with XMPP, especially when federated, the policies can be different and so it may not be fully encrypted
	+ Kathleen - yes, but would like end-to-end to be addressed
	+ NCW - yes, dataplane doesn't have to use XMPP for data transport, can provide there; is end-to-end a MUST or SHOULD for XMPP
	+ Kathleen - this could be a transport for MILE, where the exchange may be more sensitive
	+ NCW - roped in to helping Matt on draft in other WG?
	+ Dave W - need to understand the threat model around this a bit better; so that we can understand what might be in the clear what isn't to determine where the place where security/crypto is needed
	+ Kathleen M - let's get the necessary XMPP drafts out to the list (6020 and 6021 - XMPP core)
	+ NCW - __NOT VOLUNTEERING__ to put threat models out to the list, but if she finds some time


## Information Model ##
### Presenter: Lisa L ###

* Dave W - don't let the work of merging the drafts to discourage providing feedback on the individual drafts

* Dan R (chair) - yes please have small groups work to move things forward, use WebEX



	 





